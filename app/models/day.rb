class Day < ActiveRecord::Base
  belongs_to :member
  has_many :entries              , dependent: :destroy, order: 'id desc'
  # YOUR WATCHING ACTIVE REPOSITORIES
  has_many :active_repositories  , dependent: :destroy, order: 'id desc', extend: ActiveRepository::Extension
  # YOUR FRIENDS ACTIVITIES
  has_many :followings           , dependent: :destroy, order: 'id desc', extend: Following::Extension
  has_many :watchings            , dependent: :destroy, order: 'id desc', extend: Watching::Extension
  # YOUR OR YOUR REPO WATCHERS
  has_many :watchers             , dependent: :destroy, order: 'id desc', extend: Watcher::Extension
  has_many :followers            , dependent: :destroy, order: 'id desc', extend: Follower::Extension

  attr_accessible :number, :published_on, :sended

  scope :in_a_week, limit: 7

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

  def generate
    logger.info "Day: #{self.number}"
    self.entries.ungenerated.each do |entry|
      begin
        logger.info "Entry: #{entry.short_id}"
        Day.transaction do
          author = User.get(entry.author)
          if entry.all_watch_event?
            repo = Repository.get(entry.watching_repository)
            if repo # repo was destroyed
              if repo.user.login == self.member.login # your repo?
                watcher = self.watchers.on entry.watching_repository
                watcher.authors.add author
              else
                watching = self.watchings.on entry.watching_repository
                watching.authors.add author
              end
            end
          elsif entry.all_follow_event?
            if entry.following_user == self.member.login
              self.followers.add author
            else
              following = self.followings.with entry.following_user
              following.authors.add author
            end
          elsif entry.all_activity_event? # issue, comment event
            self.active_repositories.add entry
          end
          entry.generated!
        end
      rescue Errno::ETIMEDOUT, Faraday::Error::TimeoutError, Faraday::Error::ConnectionFailed, Faraday::Error::ParsingError, Octokit::InternalServerError
        logger.info "Connect Error: #{entry.short_id}"
      end
    end
  end
end
