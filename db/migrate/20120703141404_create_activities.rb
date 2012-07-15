class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :active_repository, null: false
      t.belongs_to :author           , null: false
      t.string :event                , null: false, limit: 32
      t.text :settings
      t.datetime :published_at       , null: false
    end
  end
end
