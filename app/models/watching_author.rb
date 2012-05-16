class WatchingAuthor < ActiveRecord::Base
  belongs_to :watching
  belongs_to :author, :class_name => 'User'

  scope :preview, limit: 10
end
