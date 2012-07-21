class Repository < ActiveRecord::Base
  belongs_to :user
  has_many :issues , extend: Issue::Extension
  has_many :commits, extend: Commit::Extension
  has_many :activities  , dependent: :destroy, order: 'published_at desc', extend: Activity::Extension
  attr_accessible :user_id, :fullname, :description, :homepage, :language, :watchers

  scope :preview, limit: 2
  @@etag = nil

  # @fullname saberma/shopqi
  def self.get(fullname, json = nil, user = nil)
    repo = self.find_by_fullname(fullname)
    unless repo
      json ||= Octokit.repo(fullname)
      user ||= User.get(json['owner']['login'], with_repositories: false)
      repo = self.create({
        :fullname => fullname,
        :user_id => user.id,
        :description => json['description'],
        :homepage => json['homepage'],
        :language => json['language'],
        :watchers => json['watchers']
      })
    end
    repo
  rescue Octokit::NotFound
  end

  def self.get_activities_feed
    url = "https://github.com/#{SecretSetting.tracker.login}.private.atom?token=#{SecretSetting.tracker.token}"
    feed = Feedzirra::Feed.fetch_and_parse(url, max_redirects: 3, timeout: 30)
    unless feed.is_a?(Integer) # 发生错误时feed为错误码
      if feed.etag != @@etag
        self.transaction do
          feed.repo_entries.reverse_each do |entry|
            RepositoryEntry.add entry
          end
          @@etag = feed.etag
        end
      end
    end
  rescue => e
    ExceptionNotifier::Notifier.background_exception_notification(e)
  end

  def name
    self.fullname.split('/').second
  end

  def uri
    "https://github.com/#{fullname}"
  end

end
