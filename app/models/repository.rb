class Repository < ActiveRecord::Base
  belongs_to :user
  has_many :issues, extend: Issue::Extension
  attr_accessible :user, :fullname, :description, :homepage, :language, :watchers

  scope :preview, limit: 2

  # @fullname saberma/shopqi
  def self.get(fullname, json = nil, user = nil)
    repo = self.find_by_fullname(fullname)
    unless repo
      json ||= Octokit.repo(fullname)
      user ||= User.get(json['owner']['login'], with_repositories: false)
      repo = self.create({
        :fullname => fullname,
        :user => user,
        :description => json['description'],
        :homepage => json['homepage'],
        :language => json['language'],
        :watchers => json['watchers']
      })
    end
    repo
  rescue Octokit::NotFound
  end

  def name
    self.fullname.split('/').second
  end

  def uri
    "https://github.com/#{fullname}"
  end
end
