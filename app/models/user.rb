class User < ActiveRecord::Base
  has_many :repositories, order: 'watchers desc'

  def self.get(login)
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
      repos = Octokit.repos(login, per_page: 100)
      repos.reject(&:fork).each do |json|
        Repository.get "#{login}/#{json['name']}", json, user
      end
    end
    user
  end

  def uri
    "https://github.com/#{login}"
  end

  def description
    info = []
    info << "based in #{self.location}" unless self.location.blank?
    info << "working at #{self.company}" unless self.company.blank?
    info.compact.join(', ')
  end

  def blog
    return unless super
    (super.start_with?('http://') or super.start_with?('https://')) ? super : "http://#{super}"
  end
end
