class Watcher < ActiveRecord::Base
  belongs_to :day
  belongs_to :repository
  has_many :authors, dependent: :destroy, :class_name => 'WatcherAuthor' # who watch this repo

  module Extension

    def day
      @association.owner
    end

    def on(fullname)
      repo = Repository.get(fullname)
      watcher = day.watchers.find_by_repository_id(repo.id)
      unless watcher
        watcher = day.watchers.create repository: repo
      end
      watcher
    end

  end
end
