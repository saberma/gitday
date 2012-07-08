class CreateActiveRepositories < ActiveRecord::Migration
  def change
    create_table :active_repositories do |t|
      t.belongs_to :day
      t.belongs_to :repository
      t.integer :activities_count, default: 0
    end
  end
end
