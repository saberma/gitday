module Feedzirra
  module Parser
    class GithubNewsAtomEntry
      include SAXMachine
      include FeedEntryUtilities
      TAG_REGEXP = Regexp.new("#{Feedzirra::Parser::GithubNewsAtom::TAG_PREFIX}:(\\w+)\\/(\\d+)")
      # IssuesEvent PullRequestEvent
      # http://developer.github.com/v3/events/types
      EVENT = %w(CreateEvent FollowEvent IssueCommentEvent PushEvent MemberEvent WatchEvent ForkEvent)
      USER_EVENT = %w(CreateEvent FollowEvent WatchEvent ForkEvent)
      REPO_EVENT = %w(IssueCommentEvent PushEvent MemberEvent)
      
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
        if fork_event? # title: saberma forked rails/rails, uri: saberma/rails
          title.sub "#{author.name} forked ", ''
        else
          uri.sub 'https://github.com/', ''
        end
      end

      def ignore?
        !EVENT.include?(event) or create_tag_event? or create_branch_event?
      end

      def repo?
        !ignore? and REPO_EVENT.include?(event)
      end

      def user?
        !ignore? and USER_EVENT.include?(event)
      end

      begin 'events'

        def fork_event?
          event == 'ForkEvent'
        end

        def comment_event?
          event == 'IssueCommentEvent'
        end

        def push_event?
          event == 'PushEvent'
        end

        def create_tag_event?
          event == 'CreateEvent' and title.include?('created tag')
        end

        def create_branch_event?
          event == 'CreateEvent' and title.include?('created branch')
        end

      end

      begin 'push event'

        def ref # branch name
          title.match(/.+pushed to (.+) at .+/)[1] if push_event?
        end

        def shas
          Nokogiri::HTML(content).css(".commits ul li a:nth-child(2)").map do |link|
            link.content
          end if push_event?
        end
      end
    end
  end
end
