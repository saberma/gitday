class RemoveDayFromEntry < ActiveRecord::Migration
  def up
    add_column :entries, :member_id, :integer
    Entry.find_each(batch_size: 500) do |entry|
      day = Day.find entry.day_id
      entry.update_attribute :member_id, day.member_id
    end
    remove_index :entries, :day_id
    remove_column :entries, :day_id
  end

  def down
    add_column :entries, :day_id, :integer
    add_index :entries, :day_id
    Entry.find_each(batch_size: 500) do |entry|
      member = Member.find entry.member_id
      day = member.days.get entry.published_at
      entry.update_attribute :day_id, day.id
    end
    remove_column :entries, :member_id
  end
end
