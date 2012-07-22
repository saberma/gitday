class Entry < ActiveRecord::Base
  include Event
  belongs_to :member # repo entries from gitday feed do not have member
  store :settings, accessors: [ :ref, :shas ] # Push: ref, shas.
  attr_accessible :member_id, :short_id, :link, :author, :generated, :published_at, :ref, :shas
  scope :ungenerated, where(:generated => false)

  def self.add(feed_entry, member = nil)
    unless Entry.exists?(short_id: feed_entry.short_id)
      logger.info "Set: #{feed_entry.title}"
      attributes = {
        short_id: feed_entry.short_id,
        published_at: feed_entry.published,
        link: feed_entry.link,
        author: feed_entry.author.name,
      }
      attributes.merge! member_id: member.id if member
      attributes.merge! ref: feed_entry.ref, shas: feed_entry.shas if feed_entry.push_event?
      Entry.create attributes
    end
  end

  def self.generate
    ungenerated.find_each(batch_size: 500) do |entry|
      entry.generate
    end
  rescue => e
    ExceptionNotifier::Notifier.background_exception_notification(e)
    raise e
  end

  def generate
    logger.info "Entry: #{self.short_id}"
    self.class.transaction do
      if member
        generate_for_member
      else
        generate_for_repo
      end
      self.update_attributes! generated: true
    end
  rescue Errno::ETIMEDOUT, Faraday::Error::TimeoutError, Faraday::Error::ConnectionFailed, Faraday::Error::ParsingError, Octokit::InternalServerError
    logger.info "Connect Error: #{self.short_id}"
  end

  def generate_for_member
    user = User.get(self.author)
    day = member.days.get self.published_at
    if self.all_watch_event?
      repo = Repository.get(self.repository)
      if repo # repo was destroyed
        if repo.user.login == member.login # your repo?
          watcher = day.watchers.on self.repository
          watcher.authors.add user
        else
          watching = day.watchings.on self.repository
          watching.authors.add user
        end
      end
    elsif self.all_follow_event?
      if self.following_user == member.login
        day.followers.add user
      else
        following = day.followings.with self.following_user
        following.authors.add user
      end
    end
  end

  def generate_for_repo
    repo = Repository.get self.repository
    repo.activities.add self
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

  def repository
    if all_watch_event?
      link.strip
    elsif all_activity_event?
      if issue_comment_event?
        link.sub(/\/issues.+/, '')
      elsif push_event?
        link.sub(/\/compare.+/, '')
      end
    end
  end

  begin 'activity'

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
