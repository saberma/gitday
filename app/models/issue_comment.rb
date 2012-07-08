class IssueComment < ActiveRecord::Base
  belongs_to :issue
  attr_accessible :comment_id, :body

  module Extension

    def issue
      @association.owner
    end

    def get(comment_id)
      comment = self.find_by_comment_id(comment_id)
      unless comment
        json = Octokit.issue_comment(issue.repository.fullname, comment_id)
        comment = issue.comments.create({
          :comment_id => comment_id,
          :body => json['body']
        })
      end
      comment
    end

  end
end
