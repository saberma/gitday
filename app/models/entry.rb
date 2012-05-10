class Entry < ActiveRecord::Base

  def uri
    "https://github.com/#{self.link}"
  end

  def event
    short_id.split('/').first
  end

  def following_user
    link if follow_event?
  end

  def watching_repository
    link if watch_event?
  end

  begin 'events'

    def follow_event?
      event == 'FollowEvent'
    end

    def watch_event?
      event == 'WatchEvent'
    end

  end
end
