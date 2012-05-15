#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "production"

require File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "config", "environment"))

$running = true
Signal.trap("TERM") do 
  $running = false
end

i = 0
while($running) do
  i += 1
  Rails.logger.auto_flushing = true
  Rails.logger.info "Member.get_news_feed:#{i}"
  Member.get_news_feed

  #Rails.logger.info "This daemon is still running at #{Time.now}.\n"
  
  sleep 5
end
