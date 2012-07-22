# Read about factories at http://github.com/thoughtbot/factory_girl 
FactoryGirl.define do

  factory :entry do
  end

  begin 'shopqi'

    factory :watching_shopqi_entry, parent: :entry do
      short_id "WatchEvent/1550177528"
      link "saberma/shopqi"
      author "camelsong"
      published_at '2012-05-21 10:20:30'
    end

    factory :forked_shopqi_entry, parent: :entry do
      short_id "ForkEvent/1550188528"
      link "saberma/shopqi"
      author "camelsong"
      published_at '2012-05-21 11:20:30'
    end

  end

  begin 'AjaxCRUD'

    factory :watching_ajax_crud_entry, parent: :entry do
      short_id "WatchEvent/1550177528"
      link "camelsong/AjaxCRUD"
      author "ichord"
      published_at '2012-05-21 10:20:30'
    end

    factory :forked_ajax_crud_entry, parent: :entry do
      short_id "ForkEvent/1550188528"
      link "camelsong/AjaxCRUD"
      author "ichord"
      published_at '2012-05-21 11:20:30'
    end

  end

  begin 'rails/rails'

    factory :pushed_to_branch, parent: :entry do
      short_id "PushEvent/1576276169"
      link "rails/rails/compare/089371ac23...a37b90caf4"
      author "fxn"
      published_at '2012-07-21 06:06:13'
      ref '3-2-stable'
      shas ['a37b90c']
    end

    factory :comment, parent: :entry do
      short_id "IssueCommentEvent/1576282620"
      link "rails/rails/issues/7034#issuecomment-7150761"
      author "rafaelfranca"
      published_at '2012-07-21 07:17:05'
    end

  end

  begin 'saberma'

    factory :following_saberma_entry, parent: :entry do
      short_id "FollowEvent/1550177528"
      link "saberma"
      author "camelsong"
      published_at '2012-05-21 10:20:30'
    end

    factory :following_saberma_again_entry, parent: :entry do
      short_id "FollowEvent/1550188528"
      link "saberma"
      author "camelsong"
      published_at '2012-05-21 11:20:30'
    end

  end

  begin 'camelsong'

    factory :following_camelsong_entry, parent: :entry do
      short_id "FollowEvent/1550177528"
      link "camelsong"
      author "ichord"
      published_at '2012-05-21 10:20:30'
    end

    factory :following_camelsong_again_entry, parent: :entry do
      short_id "FollowEvent/1550188528"
      link "camelsong"
      author "ichord"
      published_at '2012-05-21 11:20:30'
    end

  end

end
