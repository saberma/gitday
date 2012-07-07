class Entry < ActiveRecord::Base
  belongs_to :day
  WATCH_EVENT = %w(CreateEvent WatchEvent ForkEvent)
  ACTIVITY_EVENT = %w(IssueCommentEvent)

  attr_accessible :short_id, :link, :author, :generated, :published_at
  scope :ungenerated, where(:generated => false)

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

  def activity_repository
    link.sub(/\/issues.+/, '') if all_activity_event?
  end

  def comment_id
    link.sub(/.+issuecomment-/, '').to_i
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
