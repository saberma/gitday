class Follower < ActiveRecord::Base
  belongs_to :day
  belongs_to :author, class_name: 'User'
  attr_accessible :author, :published_at

  module Extension

    def day
      @association.owner
    end

    def add(user)
      follower = day.followers.find_by_author_id(user.id)
      unless follower
        follower = day.followers.create author: user
      end
      follower
    end

  end
end
