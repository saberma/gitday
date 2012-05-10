class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, limit: 32
      t.string :name, limit: 32
      t.string :company, limit: 64
      t.string :blog, limit: 128
      t.string :location, limit: 64
      t.integer :public_repos
      t.integer :followers
      t.integer :following
      t.string :avatar_url, limit: 255
      t.string :gravatar_id, limit: 32

      t.timestamps
    end
  end
end
