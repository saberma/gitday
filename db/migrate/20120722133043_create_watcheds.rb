class CreateWatcheds < ActiveRecord::Migration
  def change
    create_table :watcheds do |t|
      t.references :member    , null: false
      t.references :repository, null: false

      t.datetime :created_at  , null: false
    end
    add_index :watcheds, :member_id
    add_index :watcheds, :repository_id

    Member.find_each batch_size: 50 do |member|
      member.delay.get_watched_repositories
    end
  end
end
