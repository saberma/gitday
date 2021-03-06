# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    email 'mahb45@gmail.com'
    token SecretSetting.member.token
    login 'saberma'
    time_zone 'Beijing'
  end

  factory :member_camelsong, parent: :member do
    email 'camelsong@example.com'
    token Member::FAKE_TOKEN
    login 'camelsong'
  end
end
