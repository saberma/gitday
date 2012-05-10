require 'ap'

Member.all.each do |member|
  day = member.days.first
  day.generate if day
end
