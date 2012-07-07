class CreateActiveRepositories < ActiveRecord::Migration
  def change
    create_table :active_repositories do |t|
      t.belongs_to :day
      t.belongs_to :repository
    end
  end
end
