class Activity < ActiveRecord::Base
  include Event
  extend ActiveSupport::Memoizable
  belongs_to :repository
  belongs_to :author, class_name: 'User'
  store :settings, accessors: [ :comment_id, :ref, :shas ] # IssueComment: comment_id. Push: ref, shas
  attr_accessible :author_id, :event, :published_at, :comment_id, :ref, :shas

  begin 'issue comment'

    def comment
      IssueComment.find_by_comment_id(comment_id)
    end
    memoize :comment

    def issue
      comment.issue
    end
    memoize :issue

  end

  begin 'push'

    def commits
      self.active_repository.repository.commits.where(sha: self.shas)
    end
    memoize :commits

  end
end
