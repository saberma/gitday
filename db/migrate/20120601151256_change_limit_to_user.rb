class ChangeLimitToUser < ActiveRecord::Migration # https://api.github.com/users/RailsApps
  def up
    change_column :users, :login, :string, :limit => 64
    change_column :users, :name, :string, :limit => 64
    change_column :entries, :author, :string, :limit => 64
  end

  def down
    change_column :users, :login, :string, :limit => 32
    change_column :users, :name, :string, :limit => 32
    change_column :entries, :author, :string, :limit => 32
  end
end
