class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :short_id    , :null => :false, :limit => 32 , :unique => true
      t.belongs_to :day     , :null => :false
      t.string :link        , :limit => 64
      #t.string :title       , :null => false , :limit => 128
      t.string :author      , :limit => 16
      #t.string :author_email, :limit => 32
      #t.string :author_uri  , :limit => 64
      #t.string :content     , :limit => 1024
      #t.string :thumbnail   , :limit => 255
      #t.string :event   , :limit => 32
      t.boolean :generated   , :default => false # generated for day report?

      t.datetime :published_at
    end
    add_index :entries, :short_id, :unique => true
    add_index :entries, :day_id
  end
end
