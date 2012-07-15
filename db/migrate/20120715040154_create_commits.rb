class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.belongs_to :repository, null: false
      t.belongs_to :author
      t.string :sha           , null: false
      t.text :message
      t.datetime :published_at, null: false
    end
    add_index :commits, :sha, unique: true
  end
end
