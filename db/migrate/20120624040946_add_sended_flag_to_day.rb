class AddSendedFlagToDay < ActiveRecord::Migration
  def change
    add_column :days, :sended, :boolean, :default => false
  end
end
