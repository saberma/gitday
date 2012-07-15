# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :commit do
      sha "MyString"
      author_id 1
      message "MyText"
    end
end