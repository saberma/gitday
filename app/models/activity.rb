class Activity < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  attr_accessible :author, :event, :published_at
end
