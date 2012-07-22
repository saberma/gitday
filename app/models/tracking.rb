class Tracking < ActiveRecord::Base
  belongs_to :member
  belongs_to :repository
  # attr_accessible :title, :body
end
