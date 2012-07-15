class Commit < ActiveRecord::Base
  belongs_to :repository
  belongs_to :author, :class_name => 'User'
  attr_accessible :sha, :author_id, :message, :published_at

  module Extension

    def repository
      @association.owner
    end

    def add(sha)
      commit = self.find_by_sha(sha)
      unless commit
        json = Octokit.commit(repository.fullname, sha)
        user = User.get(json['author']['login'], with_repositories: false)
        commit = repository.commits.create({
          sha: sha,
          message: json['commit']['message'],
          author_id: user.id,
          published_at: json['commit']['author']['date']
        })
      end
      commit
    end

  end

  def uri
    "https://github.com/#{repository.fullname}/commit/#{self.sha}"
  end
end
