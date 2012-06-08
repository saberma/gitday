class ChangeLimitToRepo < ActiveRecord::Migration
  def up
    change_column :repositories, :description, :text, :limit => nil
  end

  def down
    change_column :repositories, :description, :string, :limit => 512
  end
end
