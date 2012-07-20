class RepositoryEntry < ActiveRecord::Base
  store :settings, accessors: [ :ref, :shas ] # Push: ref, shas.
  attr_accessible :short_id, :link, :author, :generated, :published_at, :ref, :shas
  scope :ungenerated, where(generated: false)

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

end
