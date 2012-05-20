class ChangeLimitToEntry < ActiveRecord::Migration
  def up
    change_column :entries, :link, :string, :limit => 128
    change_column :entries, :author, :string, :limit => 32
  end

  def down
    change_column :entries, :link, :string, :limit => 64
    change_column :entries, :author, :string, :limit => 16
  end
end
