class Entry < ActiveRecord::Base
  WATCH_EVENT = %w(CreateEvent WatchEvent ForkEvent)

  def uri
    "https://github.com/#{self.link}"
  end

  def event
    short_id.split('/').first
  end

  def following_user
    link if all_follow_event?
  end

  def watching_repository
    link if all_watch_event?
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

  end
end
