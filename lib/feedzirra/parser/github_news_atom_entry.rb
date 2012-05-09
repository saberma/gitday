module Feedzirra
  module Parser
    class GithubNewsAtomEntry
      include SAXMachine
      include FeedEntryUtilities
      TAG_REGEXP = Regexp.new("#{Feedzirra::Parser::GithubNewsAtom::TAG_PREFIX}:(\\w+)\\/(\\d+)")
      # IssueCommentEvent IssuesEvent PullRequestEvent PushEvent
      # http://developer.github.com/v3/events/types
      EVENT = %w(CreateEvent FollowEvent MemberEvent WatchEvent ForkEvent)
      
      element :id, :as => :entry_id # tag:github.com,2008:GollumEvent/1549035188
      element :published
      element :updated
      element :link, :as => :uri, :value => :href, :with => {:type => "text/html", :rel => "alternate"}
      element :title
      element :content
      elements :author, :as => :authors, :class => Feedzirra::Parser::GithubNewsAtomEntryAuthor
      element :"media:thumbnail", :as => :thumbnail, :value => :url

      def author
        authors.first
      end

      def event
        @event_and_number ||= entry_id.scan(TAG_REGEXP).flatten
        @event_and_number.first
      end

      def number
        @event_and_number ||= entry_id.scan(TAG_REGEXP).flatten
        @event_and_number.second
      end

      def short_id
        "#{event}/#{number}"
      end

      def link
        uri.sub 'https://github.com/', ''
      end

      def ignore?
        !EVENT.include? event
        false
      end
    end
  end
end
