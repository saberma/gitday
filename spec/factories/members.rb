# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    email 'mahb45@gmail.com'
    token SecretSetting.author.token
    login 'saberma'
  end
end
