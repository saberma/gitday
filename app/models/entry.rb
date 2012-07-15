class Entry < ActiveRecord::Base
  belongs_to :day
  WATCH_EVENT = %w(CreateEvent WatchEvent ForkEvent)
  ACTIVITY_EVENT = %w(IssueCommentEvent)
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

  def generated!
    self.update_attributes! :generated => true
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

  begin 'issue comment'

    def active_repository
      link.sub(/\/issues.+/, '') if all_activity_event?
    end

    def issue_number
      link.match(/.+issues\/(\d+)#issuecomment.+/)[1].to_i
    end

    def comment_id
      link.sub(/.+issuecomment-/, '').to_i
    end

  end

  begin 'events'

    def follow_event?
      self.all_watch_event?
    end

    def watch_event?
      event == 'WatchEvent'
    end

    def all_follow_event?
      event == 'FollowEvent'
    end

    def all_watch_event?
      WATCH_EVENT.include? event
    end

    def all_activity_event?
      ACTIVITY_EVENT.include? event
    end

  end
end
