class CreateFollowingAuthors < ActiveRecord::Migration
  def change
    create_table :following_authors do |t|
      t.belongs_to :follow
      t.belongs_to :author
      t.datetime :created_at
    end
    add_index :following_authors, :follow_id
  end
end
