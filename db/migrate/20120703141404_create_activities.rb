class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :day
      t.belongs_to :repository
      t.belongs_to :author
      t.string :event, limit: 32
      t.datetime :published_at

      t.timestamps
    end
  end
end
