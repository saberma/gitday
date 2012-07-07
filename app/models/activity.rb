class Activity < ActiveRecord::Base
  belongs_to :day
  belongs_to :repository
  belongs_to :author, class_name: 'User'
  attr_accessible :repository, :author, :event, :published_at

  module Extension

    def day
      @association.owner
    end

    def add(repo_fullname, user, event, published_at)
      repo = Repository.get(repo_fullname)
      day.activities.create repository: repo, author: user, event: event, published_at: published_at
    end

  end
end
