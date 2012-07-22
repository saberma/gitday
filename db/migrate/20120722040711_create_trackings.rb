class CreateTrackings < ActiveRecord::Migration
  def change
    create_table :trackings do |t|
      t.references :member    , null: false
      t.references :repository, null: false

      t.datetime :created_at  , null: false
    end
    add_index :trackings, :member_id
    add_index :trackings, :repository_id
  end
end
