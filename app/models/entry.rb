class Entry < ActiveRecord::Base

  def uri
    "https://github.com/#{self.link}"
  end

  def event
    short_id.split('/').first
  end

  begin 'events'

    def follow_event?
      event == 'FollowEvent'
    end

  end
end
