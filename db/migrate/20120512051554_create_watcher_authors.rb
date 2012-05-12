class CreateWatcherAuthors < ActiveRecord::Migration
  def change
    create_table :watcher_authors do |t|
      t.belongs_to :watcher
      t.belongs_to :author
      t.datetime :created_at
    end
  end
end
