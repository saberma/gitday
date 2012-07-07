class ActiveRepository < ActiveRecord::Base
  belongs_to :day
  belongs_to :repository
  has_many :activities  , dependent: :destroy, order: 'id desc'
  attr_accessible :repository

  module Extension

    def day
      @association.owner
    end

    def add(repo_fullname, user, event, published_at)
      repo = Repository.get(repo_fullname)
      active_repo = find_by_repository_id(repo.id)
      active_repo ||= day.active_repositories.create(repository: repo)
      active_repo.activities.create author: user, event: event, published_at: published_at
    end

  end
end
