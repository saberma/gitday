class Watching < ActiveRecord::Base
  belongs_to :day
  belongs_to :repository
  has_many :authors, dependent: :destroy, :class_name => 'WatchingAuthor' # who watching this repository

  def authors_name
    self.authors.map(&:author).map(&:name).join(', ')
  end

  module Extension

    def day
      @association.owner
    end

    def on(fullname)
      repo = Repository.get(fullname)
      watching = day.watchings.find_by_repository_id(repo.id)
      unless watching
        watching = day.watchings.create repository: repo
      end
      watching
    end

  end
end
