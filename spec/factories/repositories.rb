# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shopqi, class: Repository do
    association :user, factory: :saberma
    fullname 'saberma/shopqi'
    language 'ruby'
    watchers 245
  end

  factory :ajax_crud, class: Repository do
    association :user, factory: :camelsong
    fullname 'camelsong/AjaxCRUD'
    language 'ruby'
    watchers 4
  end
end
