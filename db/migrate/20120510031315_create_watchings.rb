class CreateWatchings < ActiveRecord::Migration
  def change
    create_table :watchings do |t|
      t.belongs_to :day
      t.belongs_to :repository
      t.datetime :created_at
    end
    add_index :watchings, :day_id
  end
end
