class Activity < ActiveRecord::Base
  include Event
  belongs_to :repository
  belongs_to :author, class_name: 'User'
  store :settings, accessors: [ :comment_id, :ref, :shas ] # IssueComment: comment_id. Push: ref, shas
  attr_accessible :author_id, :event, :published_at, :comment_id, :ref, :shas

  scope :today, lambda { on(Date.today, 'UTC') }
  scope :on, lambda {|date, time_zone|
    start = Date.today.to_time.in_time_zone(time_zone).beginning_of_day
    ends  = Date.today.to_time.in_time_zone(time_zone).end_of_day
    where(published_at: start..ends)
  }

  module Extension

    def repository
      @association.owner
    end

    def add(entry)
      user = User.get(entry.author)
      attributes = { author_id: user.id, event: entry.event, published_at: entry.published_at }
      if entry.issue_comment_event?
        issue = repository.issues.get(entry.issue_number)
        issue.comments.get(entry.comment_id)
        attributes.merge! comment_id: entry.comment_id
      elsif entry.push_event?
        entry.shas.each do |sha|
          repository.commits.add sha
        end
        attributes.merge! ref: entry.ref, shas: entry.shas
      end
      repository.activities.create attributes
    rescue Octokit::NotFound
      logger.info "Octokit NotFound Error: #{entry.short_id}"
    end

  end

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
      @commits ||= repository.commits.where(sha: self.shas)
    end

  end
end
