module Feedzirra
  module Parser
    class GithubNewsAtom
      include SAXMachine
      include FeedUtilities
      attr_accessor :entries
      TAG_PREFIX = "tag:github\\.com,2008"

      element :title
      element :link, :as => :url, :value => :href, :with => {:type => "text/html"}
      element :link, :as => :feed_url, :value => :href, :with => {:type => "application/atom+xml"}
      element :updated
      elements :entry, :as => :orig_entries, :class => Feedzirra::Parser::GithubNewsAtomEntry

      def self.able_to_parse?(xml) #:nodoc:
        %r{<id>tag:github\.com,2008.*private\</id\>} =~ xml
      end

      def user_entries
        orig_entries.select(&:user?)
      end

      def repo_entries
        orig_entries.select(&:repo?)
      end

      def etag_with_strip # remove etag quote
        etag_without_strip.gsub /"/, ''
      end

      alias_method_chain :etag, :strip
    end
  end
end
