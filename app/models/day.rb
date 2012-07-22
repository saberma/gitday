class Day < ActiveRecord::Base
  belongs_to :member
  # YOUR FRIENDS ACTIVITIES
  has_many :followings               , dependent: :destroy, order: 'id desc'              , extend: Following::Extension
  has_many :watchings                , dependent: :destroy, order: 'id desc'              , extend: Watching::Extension
  # YOUR OR YOUR REPO WATCHERS
  has_many :watchers                 , dependent: :destroy, order: 'id desc'              , extend: Watcher::Extension
  has_many :followers                , dependent: :destroy, order: 'id desc'              , extend: Follower::Extension

  attr_accessible :number, :published_on, :sended

  module Extension # http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html #Association extensions

    def member
      @association.owner
    end

    def get(published)
      published = published.in_time_zone(member.time_zone).to_date
      unless day = find_by_published_on(published)
        number = member.days.size + 1
        day = self.create! :number => number, :published_on => published
      end
      day
    end

    def latest
      where(["published_on < ?", Time.now.in_time_zone(member.time_zone).to_date]).first
    end

  end

  def today?
    Time.now.in_time_zone(member.time_zone).to_date == self.published_on
  end

  def title
    "Day #{self.number}"
  end
end
