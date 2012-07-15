class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :active_repository
      t.belongs_to :author
      t.string :event, limit: 32
      t.text :settings
      t.datetime :published_at
    end
  end
end
