class Activity < ActiveRecord::Base
  belongs_to :active_repository, counter_cache: true
  belongs_to :author, class_name: 'User'
  store :settings, accessors: [ :comment_id, :ref, :shas ] # IssueComment: comment_id. Push: ref, shas
  attr_accessible :author_id, :event, :published_at, :comment_id, :ref, :shas

  def action # commented on
    case event
    when 'IssueCommentEvent' then 'commented on'
    end
  end

  def name # issue #1223
    case event
    when 'IssueCommentEvent'
      comment = IssueComment.find_by_comment_id(comment_id)
      "issue #{comment.issue.number}"
    end
  end

  def link
    case event
    when 'IssueCommentEvent'
      comment = IssueComment.find_by_comment_id(comment_id)
      issue = comment.issue
      "https://github.com/#{issue.repository.fullname}/issues/#{issue.number}#issuecomment-#{comment.comment_id}"
    end
  end

  def title # issue title
    case event
    when 'IssueCommentEvent'
      comment = IssueComment.find_by_comment_id(comment_id)
      comment.issue.title
    end
  end

  def body
    case event
    when 'IssueCommentEvent'
      comment = IssueComment.find_by_comment_id(comment_id)
      comment.body
    end
  end
end
