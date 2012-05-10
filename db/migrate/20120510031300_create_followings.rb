class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.belongs_to :day
      t.belongs_to :user
      t.datetime :created_at
    end
    add_index :followings, :day_id
  end
end
