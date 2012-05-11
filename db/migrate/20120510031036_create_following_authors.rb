class CreateFollowingAuthors < ActiveRecord::Migration
  def change
    create_table :following_authors do |t|
      t.belongs_to :following
      t.belongs_to :author
      t.datetime :created_at
    end
    add_index :following_authors, :following_id
  end
end
