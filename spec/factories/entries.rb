# Read about factories at http://github.com/thoughtbot/factory_girl 
FactoryGirl.define do

  factory :entry do
    association :day, factory: :day
  end

  begin 'shopqi'

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

  begin 'AjaxCRUD'

    factory :watching_ajax_crud_entry, class: Entry do
      short_id "WatchEvent/1550177528"
      link "camelsong/AjaxCRUD"
      author "ichord"
      published_at '2012-05-21 10:20:30'
      association :day, factory: :day
    end

    factory :forked_ajax_crud_entry, class: Entry do
      short_id "ForkEvent/1550188528"
      link "camelsong/AjaxCRUD"
      author"ichord"
      published_at '2012-05-21 11:20:30'
      association :day, factory: :day
    end

  end

  begin 'saberma'

    factory :following_saberma_entry, parent: :entry do
      short_id "FollowEvent/1550177528"
      link "saberma"
      author"camelsong"
      published_at '2012-05-21 10:20:30'
    end

    factory :following_saberma_again_entry, parent: :entry do
      short_id "FollowEvent/1550188528"
      link "saberma"
      author"camelsong"
      published_at '2012-05-21 11:20:30'
    end

  end

end
