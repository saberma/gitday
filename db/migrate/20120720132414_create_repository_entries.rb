class CreateRepositoryEntries < ActiveRecord::Migration
  def change
    create_table :repository_entries do |t|
      t.string :short_id
      t.string :link
      t.string :author
      t.boolean :generated
      t.text :settings
      t.datetime :published_at

      t.timestamps
    end
  end
end
