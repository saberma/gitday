class User < ActiveRecord::Base

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
    end
    user
  end

  def uri
    "https://github.com/#{login}"
  end
end
