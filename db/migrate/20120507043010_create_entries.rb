class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :short_id    , :null => :false, :limit => 32 , :unique => true
      t.belongs_to :user    , :null => :false
      t.string :link        , :limit => 64
      t.string :title       , :null => false , :limit => 128
      t.string :author_name , :limit => 16
      t.string :author_email, :limit => 32
      t.string :author_uri  , :limit => 64
      t.string :content     , :limit => 1024
      t.string :thumbnail   , :limit => 255
      t.string :event   , :limit => 32

      t.datetime :created_at
    end
    add_index :entries, :short_id, :unique => true
    add_index :entries, :user_id
  end
end
