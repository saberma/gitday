class AddSettingsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :settings, :text
  end
end
