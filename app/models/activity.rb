class Activity < ActiveRecord::Base
  include Event
  belongs_to :repository
  belongs_to :author, class_name: 'User'
  store :settings, accessors: [ :comment_id, :ref, :shas ] # IssueComment: comment_id. Push: ref, shas
  attr_accessible :author_id, :event, :published_at, :comment_id, :ref, :shas

  begin 'issue comment'

    def comment
      @comment ||= IssueComment.find_by_comment_id(comment_id)
    end

    def issue
      @issue ||= comment.issue
    end

  end

  begin 'push'

    def commits
      @commits ||= self.active_repository.repository.commits.where(sha: self.shas)
    end

  end
end
