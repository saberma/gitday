class ChangeAllLimitToUser < ActiveRecord::Migration
  def up
    change_column :users, :name, :text
    change_column :users, :company, :text
    change_column :users, :blog, :text
    change_column :users, :location, :text
  end

  def down
    change_column :users, :name, :string, :limit => 64
    change_column :users, :company, :string, :limit => 64
    change_column :users, :blog, :string, :limit => 128
    change_column :users, :location, :string, :limit => 64
  end
end
