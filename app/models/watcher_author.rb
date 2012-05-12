class WatcherAuthor < ActiveRecord::Base
  belongs_to :watcher
  belongs_to :author, :class_name => 'User'
end
