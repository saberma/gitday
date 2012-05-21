class WatcherAuthor < ActiveRecord::Base
  belongs_to :watcher
  belongs_to :author, :class_name => 'User'

  module Extension

    def watcher
      @association.owner
    end

    def add(user)
      watcher_author = watcher.authors.find_by_author_id(user.id)
      unless watcher_author
        watcher_author = watcher.authors.create author: user
      end
      watcher_author
    end

  end
end
