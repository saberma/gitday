module Event
  WATCH_EVENT = %w(CreateEvent WatchEvent ForkEvent)
  ACTIVITY_EVENT = %w(IssueCommentEvent PushEvent)

  begin 'events'

    def follow_event?
      self.all_watch_event?
    end

    def watch_event?
      event == 'WatchEvent'
    end

    def issue_comment_event?
      event == 'IssueCommentEvent'
    end

    def push_event?
      event == 'PushEvent'
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
