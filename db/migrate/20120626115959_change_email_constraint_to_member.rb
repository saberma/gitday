class ChangeEmailConstraintToMember < ActiveRecord::Migration
  def up # some user do not publish his email
    change_column :members, :email, :string, :null => true
    remove_index :members, :email
  end

  def down
    change_column :members, :email, :string, :null => false
    add_index :members, :email, :unique => true
  end
end
