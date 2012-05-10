class CreateWatchingAuthors < ActiveRecord::Migration
  def change
    create_table :watching_authors do |t|
      t.belongs_to :watching
      t.belongs_to :author
      t.datetime :created_at
    end
    add_index :watching_authors, :watching_id
  end
end
