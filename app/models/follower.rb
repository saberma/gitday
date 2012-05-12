class Follower < ActiveRecord::Base
  belongs_to :day
  belongs_to :author, class_name: 'User'
end
