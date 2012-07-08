class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.belongs_to :repository
      t.integer :number
      t.string :title
      t.text :body
    end

    create_table :issue_comments do |t|
      t.belongs_to :issue
      t.integer :comment_id
      t.text :body
    end
  end
end
