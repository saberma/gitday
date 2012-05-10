class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.belongs_to :user, :null => false
      t.string :fullname, :null => false, :limit => 128
      t.string :description, :limit => 512
      t.string :homepage, :limit => 255
      t.string :language, :limit => 16
      t.integer :watchers
      t.timestamps
    end
  end
end
