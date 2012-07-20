# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :repository_entry do
      short_id "MyString"
      link "MyString"
      author "MyString"
      generated false
      settings "MyText"
      published_at "2012-07-20 21:24:14"
    end
end