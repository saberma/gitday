class FollowingAuthor < ActiveRecord::Base
  belongs_to :following
  belongs_to :author, :class_name => 'User'
end
