class Following < ActiveRecord::Base
  belongs_to :day
  belongs_to :user
  has_many :authors, dependent: :destroy, :class_name => 'FollowingAuthor' # who follow this user

  module Extension

    def day
      @association.owner
    end

    def with(login)
      user = User.get(login)
      following = day.following.find_by_user(user)
      unless following
        following = day.followings.create user: user
      end
    end

  end
end
