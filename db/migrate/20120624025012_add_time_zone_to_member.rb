class AddTimeZoneToMember < ActiveRecord::Migration
  def change
    add_column :members, :time_zone, :string, :limit => 32
  end
end
