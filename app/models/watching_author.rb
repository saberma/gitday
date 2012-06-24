class WatchingAuthor < ActiveRecord::Base
  belongs_to :watching
  belongs_to :author, :class_name => 'User'
  attr_accessible :author

  scope :preview, limit: 10

  module Extension

    def watching
      @association.owner
    end

    def add(user)
      watching_author = watching.authors.find_by_author_id(user.id)
      unless watching_author
        watching_author = watching.authors.create author: user
      end
      watching_author
    end

  end
end
