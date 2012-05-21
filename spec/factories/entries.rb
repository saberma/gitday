# Read about factories at http://github.com/thoughtbot/factory_girl 
FactoryGirl.define do
  factory :watching_shopqi_entry, class: Entry do
    short_id "WatchEvent/1550177528"
    link "saberma/shopqi"
    author"camelsong"
    published_at '2012-05-21 10:20:30'
    association :day, factory: :day
  end

  factory :forked_shopqi_entry, class: Entry do
    short_id "ForkEvent/1550188528"
    link "saberma/shopqi"
    author"camelsong"
    published_at '2012-05-21 11:20:30'
    association :day, factory: :day
  end
end
