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
  Rails.logger.info "[#{Time.now.to_s(:db)}] Repository.get_feed:#{i}"
  
  sleep 5
end
