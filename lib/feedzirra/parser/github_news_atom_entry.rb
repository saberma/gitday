module Feedzirra
  module Parser
    class GithubNewsAtomEntry
      include SAXMachine
      include FeedEntryUtilities
      TAG_REGEXP = Regexp.new("#{Feedzirra::Parser::GithubNewsAtom::TAG_PREFIX}:(\\w+)\\/(\\d+)")
      # IssueCommentEvent IssuesEvent PullRequestEvent PushEvent
      # http://developer.github.com/v3/events/types
      EVENT = %w(CreateEvent FollowEvent MemberEvent WatchEvent)
      
      element :id, :as => :entry_id # tag:github.com,2008:GollumEvent/1549035188
      element :published
      element :updated
      element :link, :value => :href, :with => {:type => "text/html", :rel => "alternate"}
      element :title
      element :content
      elements :author, :as => :authors, :class => Feedzirra::Parser::GithubNewsAtomEntryAuthor
      element :"media:thumbnail", :as => :thumbnail, :value => :url

      def author
        authors.first
      end

      def type
        @type_and_number ||= entry_id.scan(TAG_REGEXP).flatten
        @type_and_number.first
      end

      def number
        @type_and_number ||= entry_id.scan(TAG_REGEXP).flatten
        @type_and_number.second
      end

      def short_id
        "#{type}/#{number}"
      end

      def ignore?
        !EVENT.include? type
        false
      end
    end
  end
end
