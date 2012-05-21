class Day < ActiveRecord::Base
  belongs_to :member
  has_many :entries   , dependent: :destroy, order: 'id desc'
  has_many :followings, dependent: :destroy, order: 'id desc', extend: Following::Extension
  has_many :watchings , dependent: :destroy, order: 'id desc', extend: Watching::Extension
  has_many :watchers  , dependent: :destroy, order: 'id desc', extend: Watcher::Extension
  has_many :followers , dependent: :destroy, order: 'id desc'

  scope :in_a_week, limit: 7

  def self.latest
    where(["published_on < ?", Date.today]).first
  end

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
    self.entries.ungenerated.each do |entry|
      puts "generate:#{entry.short_id}"
      Day.transaction do
        author = User.get(entry.author)
        if entry.all_watch_event?
          repo = Repository.get(entry.watching_repository)
          if repo.user.login == self.member.login # your repo?
            watcher = self.watchers.on entry.watching_repository
            watcher.authors.add author
          else
            watching = self.watchings.on entry.watching_repository
            watching.authors.create author: author
          end
        elsif entry.all_follow_event?
          if entry.following_user == self.member.login
            self.followers.create author: author
          else
            following = self.followings.with entry.following_user
            following.authors.create author: author
          end
        end
        entry.generated!
      end
    end
  end
end
