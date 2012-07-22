class Watched < ActiveRecord::Base
  belongs_to :member
  belongs_to :repository
  attr_accessible :repository_id

  module Extension

    def member
      @association.owner
    end

    def get(repo_json)
      repo = Repository.get repo_json.full_name, repo_json
      watched = member.watcheds.find_by_repository_id(repo.id)
      unless watched
        watched = member.watcheds.create repository_id: repo.id
      end
      watched
    end

  end
end
