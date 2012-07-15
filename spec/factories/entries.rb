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

  begin 'jQuery-File-Upload'

    factory :comment_on_jquery_file_upload_entry, parent: :entry do
      short_id "IssueCommentEvent/1569204837"
      link "blueimp/jQuery-File-Upload/issues/1223#issuecomment-6733474"
      author "vuongnguyen"
      published_at '2012-07-03 11:20:30'
    end

  end

  begin 'zurb/foundation'

    factory :comment_on_zurb_foundation, parent: :entry do
      short_id "IssueCommentEvent/1573406489"
      link "zurb/foundation/issues/638#issuecomment-6982924"
      author "Anderson-Juhasc"
      published_at '2012-07-14 13:29:12'
    end

    factory :comment_on_zurb_foundation_1, parent: :entry do
      short_id "IssueCommentEvent/1573406182"
      link "zurb/foundation/issues/638#issuecomment-6982900"
      author "Anderson-Juhasc"
      published_at '2012-07-14 13:26:29'
    end

  end

  begin 'elasticsearch/elasticsearch'

    factory :pushed_to_elasticsearch, parent: :entry do
      short_id "PushEvent/1573393297"
      link "elasticsearch/elasticsearch/compare/aafa8cc905...a5e541351f"
      author "kimchy"
      published_at '2012-07-14 11:19:16'
      ref '0.19'
      shas ['a5e5413']
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
