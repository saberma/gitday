class ActiveRepository < ActiveRecord::Base
  belongs_to :day
  belongs_to :repository
  has_many :activities  , dependent: :destroy, order: 'published_at desc'
  attr_accessible :repository_id

  module Extension

    def day
      @association.owner
    end

    def get(repository_id)
      day.active_repositories.where(repository_id: repository_id).first_or_create
    end

    def add(entry)
      user = User.get(entry.author)
      repo = Repository.get(entry.active_repository)
      attributes = { author_id: user.id, event: entry.event, published_at: entry.published_at }
      if entry.issue_comment_event?
        issue = repo.issues.get(entry.issue_number)
        issue.comments.get(entry.comment_id)
        attributes.merge! comment_id: entry.comment_id
      elsif entry.push_event?
        entry.shas.each do |sha|
          repo.commits.add sha
        end
        attributes.merge! ref: entry.ref, shas: entry.shas
      end
      get(repo.id).activities.create attributes
    rescue Octokit::NotFound
      logger.info "Octokit NotFound Error: #{entry.short_id}"
    end

  end
end
