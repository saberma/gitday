class CreateWatchers < ActiveRecord::Migration
  def change
    create_table :watchers do |t|
      t.belongs_to :day
      t.belongs_to :repository
      t.datetime :published_at
    end
    add_index :watchers, :day_id
  end
end
