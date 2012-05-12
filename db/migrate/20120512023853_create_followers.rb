class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.belongs_to :day
      t.belongs_to :author
      t.datetime :published_at
    end
    add_index :followers, :day_id
  end
end
