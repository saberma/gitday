class Repository < ActiveRecord::Base
  belongs_to :user

  # @fullname saberma/shopqi
  def self.get(fullname)
    repo = self.find_by_fullname(fullname)
    unless repo
      json = Octokit.repo(fullname)
      repo = self.create({
        :fullname => fullname,
        :user => User.get(json['owner']['login']),
        :description => json['description'],
        :homepage => json['homepage'],
        :language => json['language'],
        :watchers => json['watchers']
      })
    end
    repo
  end

  def name
    self.fullname.split('/').second
  end

  def uri
    "https://github.com/#{fullname}"
  end
end
