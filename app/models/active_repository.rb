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

  end
end
