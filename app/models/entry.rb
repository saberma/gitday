class Entry < ActiveRecord::Base
  include Event
  belongs_to :member # repo entries from gitday feed do not have member
  store :settings, accessors: [ :ref, :shas ] # Push: ref, shas.
  attr_accessible :short_id, :link, :author, :generated, :published_at, :ref, :shas
  scope :ungenerated, where(:generated => false)

  module Extension

    def day
      @association.owner
    end

    def add(feed_entry)
      unless day.entries.exists?(short_id: feed_entry.short_id)
        logger.info "Set: #{feed_entry.title}"
        attributes = {
          short_id: feed_entry.short_id,
          published_at: feed_entry.published,
          link: feed_entry.link,
          author: feed_entry.author.name,
        }
        attributes.merge! ref: feed_entry.ref, shas: feed_entry.shas if feed_entry.push_event?
        day.entries.create attributes
      end
    end

  end

  def generate
    logger.info "Entry: #{self.short_id}"
    self.class.transaction do
      user = User.get(self.author)
      if self.all_watch_event?
        repo = Repository.get(self.watching_repository)
        if repo # repo was destroyed
          if repo.user.login == day.member.login # your repo?
            watcher = day.watchers.on self.watching_repository
            watcher.authors.add user
          else
            watching = day.watchings.on self.watching_repository
            watching.authors.add user
          end
        end
      elsif self.all_follow_event?
        if self.following_user == day.member.login
          day.followers.add user
        else
          following = day.followings.with self.following_user
          following.authors.add user
        end
      elsif self.all_activity_event? # issue, comment event, push
        day.active_repositories.add self
      end
      self.update_attributes! generated: true
    end
  rescue Errno::ETIMEDOUT, Faraday::Error::TimeoutError, Faraday::Error::ConnectionFailed, Faraday::Error::ParsingError, Octokit::InternalServerError
    logger.info "Connect Error: #{self.short_id}"
  end

  def uri
    "https://github.com/#{self.link.strip}"
  end

  def event
    short_id.split('/').first
  end

  def following_user
    link.strip if all_follow_event?
  end

  def watching_repository
    link.strip if all_watch_event?
  end

  begin 'activity'

    def active_repository
      if all_activity_event?
        if issue_comment_event?
          link.sub(/\/issues.+/, '')
        elsif push_event?
          link.sub(/\/compare.+/, '')
        end
      end
    end

    begin 'issue comment'

      def issue_number
        link.match(/.+issues\/(\d+)#issuecomment.+/)[1].to_i
      end

      def comment_id
        link.sub(/.+issuecomment-/, '').to_i
      end

    end

  end
end
