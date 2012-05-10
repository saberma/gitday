class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :member, :null => false
      t.integer :number   , :null => false
      t.date :published_on
    end
  end
end
