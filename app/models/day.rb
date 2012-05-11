class Day < ActiveRecord::Base
  belongs_to :member
  has_many :entries   , dependent: :destroy, order: 'id desc'
  has_many :followings, dependent: :destroy, order: 'id desc', extend: Following::Extension
  has_many :watchings , dependent: :destroy, order: 'id desc', extend: Watching::Extension

  module Extension # http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html #Association extensions

    def member
      @association.owner
    end

    def get(published)
      published = published.to_date
      unless day = find_by_published_on(published)
        number = member.days.size + 1
        day = self.create! :number => number, :published_on => published
      end
      day
    end

  end

  def generate
    self.entries.each do |entry|
      Day.transaction do
        if entry.all_watch_event?
          p '========='
          p entry.watching_repository
          watching = self.watchings.on entry.watching_repository
          ap watching
          watching.authors.create author: User.get(entry.author)
        elsif entry.all_follow_event?
          following = self.followings.with entry.following_user
          following.authors.create author: User.get(entry.author)
        end
      end
    end
  end
end
