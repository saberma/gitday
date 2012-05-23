class RemoveShortIdUniqueToEntry < ActiveRecord::Migration
  def up # short_id is only unique for the creator
    change_column :entries, :short_id, :string, :unique => false
    remove_index :entries, :column => :short_id
  end

  def down
    change_column :entries, :short_id, :string, :unique => true
    add_index :entries, :short_id
  end
end
