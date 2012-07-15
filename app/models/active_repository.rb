class ActiveRepository < ActiveRecord::Base
  belongs_to :day
  belongs_to :repository
  has_many :activities  , dependent: :destroy, order: 'published_at desc'
  attr_accessible :repository_id

  module Extension

    def day
      @association.owner
    end

    def add(entry)
      user = User.get(entry.author)
      repo = Repository.get(entry.active_repository)
      issue = repo.issues.get(entry.issue_number)
      issue.comments.get(entry.comment_id)
      active_repo = find_by_repository_id(repo.id)
      active_repo ||= day.active_repositories.create(repository_id: repo.id)
      active_repo.activities.create author: user, event: entry.event, comment_id: entry.comment_id, published_at: entry.published_at
    end

  end
end
