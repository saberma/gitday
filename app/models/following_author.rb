class FollowingAuthor < ActiveRecord::Base
  belongs_to :following
  belongs_to :author, :class_name => 'User'

  scope :preview, limit: 10

  module Extension

    def following
      @association.owner
    end

    def add(user)
      following_author = following.authors.find_by_author_id(user.id)
      unless following_author
        following_author = following.authors.create author: user
      end
      following_author
    end

  end
end
