class RepositoryEntry < ActiveRecord::Base
  store :settings, accessors: [ :ref, :shas ] # Push: ref, shas.
  attr_accessible :short_id, :link, :author, :generated, :published_at, :ref, :shas
  scope :ungenerated, where(generated: false)

  def generate
    self.class.transaction do
      if self.all_activity_event? # issue, comment event, push
        user = User.get(self.author, with_repositories: false)
        repo = Repository.get(self.active_repository)
        attributes = { author_id: user.id, event: self.event, published_at: self.published_at }
        if self.issue_comment_event?
          issue = repo.issues.get(self.issue_number)
          issue.comments.get(self.comment_id)
          attributes.merge! comment_id: self.comment_id
        elsif self.push_event?
          self.shas.each do |sha|
            repo.commits.add sha
          end
          attributes.merge! ref: self.ref, shas: self.shas
        end
        repo.activities.create attributes
      end
      self.update_attributes! generated: true
    end
  rescue Errno::ETIMEDOUT, Faraday::Error::TimeoutError, Faraday::Error::ConnectionFailed, Faraday::Error::ParsingError, Octokit::InternalServerError
    logger.info "Connect Error: #{self.short_id}"
  rescue Octokit::NotFound
    logger.info "Octokit NotFound Error: #{entry.short_id}"
  end

  def self.add(feed_entry)
    unless self.exists?(short_id: feed_entry.short_id)
      logger.info "Set: #{feed_entry.title}"
      attributes = {
        short_id: feed_entry.short_id,
        published_at: feed_entry.published,
        link: feed_entry.link,
        author: feed_entry.author.name,
      }
      attributes.merge! ref: feed_entry.ref, shas: feed_entry.shas if feed_entry.push_event?
      self.create attributes
    end
  end

  def self.generate
    self.ungenerated.map(&:generate)
  rescue => e
    ExceptionNotifier::Notifier.background_exception_notification(e)
    raise e
  end

end
