class Following < ActiveRecord::Base
  belongs_to :day
  belongs_to :user
  has_many :authors, dependent: :destroy, :class_name => 'FollowingAuthor', extend: FollowingAuthor::Extension # who follow this user

  module Extension

    def day
      @association.owner
    end

    def with(login)
      user = User.get(login)
      following = day.followings.find_by_user_id(user.id)
      unless following
        following = day.followings.create user: user
      end
      following
    end

  end
end
