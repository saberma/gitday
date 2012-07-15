class User < ActiveRecord::Base
  has_many :repositories, order: 'watchers desc'
  attr_accessible :login, :name, :company, :blog, :location, :public_repos, :followers, :following, :avatar_url, :gravatar_id

  before_validation do
    self.company = self.company[0, 64] if company and company.size > 64
  end

  def self.get(login, options = {})
    options.reverse_merge! with_repositories: true
    user = self.find_by_login(login)
    unless user
      json = Octokit.user(login)
      user = self.create({
        :login => login,
        :name => json['name'],
        :company => json['company'],
        :blog => json['blog'],
        :location => json['location'],
        :public_repos => json['public_repos'],
        :followers => json['followers'],
        :following => json['following'],
        :avatar_url => json['avatar_url'],
        :gravatar_id => json['gravatar_id']
      })
      if options[:with_repositories]
        repos = Octokit.repos(login, per_page: 100)
        repos.reject(&:fork).each do |json|
          Repository.get "#{login}/#{json['name']}", json, user
        end
      end
    end
    user
  end

  def uri
    "https://github.com/#{login}"
  end

  def description
    info = []
    info << "has #{self.public_repos} public repos and #{self.followers} followers"
    info << "based in #{self.location}" unless self.location.blank?
    info << "working at #{self.company}" unless self.company.blank?
    info.compact.join(', ')
  end

  def blog
    return unless super
    (super.start_with?('http://') or super.start_with?('https://')) ? super : "http://#{super}"
  end
end
