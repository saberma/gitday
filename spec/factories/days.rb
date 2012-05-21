# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day do
    association :member, factory: :member
    number 1
    published_on '2012-05-21'
  end
end
