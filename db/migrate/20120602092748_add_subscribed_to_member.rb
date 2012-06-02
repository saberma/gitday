class AddSubscribedToMember < ActiveRecord::Migration
  def change
    add_column :members, :subscribed, :boolean, :default => true
  end
end
