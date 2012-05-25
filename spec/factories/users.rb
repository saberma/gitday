# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :saberma, class: User do
    login :saberma
    name :saberma
    company :shopqi
    blog 'www.shopqi.com'
    location 'ShenZhen China'
    public_repos 22
    followers 153
    following 39
    avatar_url 'https://secure.gravatar.com/avatar/871c4ba6d25169779cee977e04b2f0c3?s=30&amp;d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png'
    gravatar_id '871c4ba6d25169779cee977e04b2f0c3'
  end

  factory :camelsong, class: User do
    login :camelsong
    name :camel
    company :kd
    blog 'http://rubyer.me'
    location 'shenzhen'
    public_repos 22
    followers 31
    following 27
    avatar_url 'https://secure.gravatar.com/avatar/ab989bfcd6ed51d34250507f7a248653?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png'
    gravatar_id 'ab989bfcd6ed51d34250507f7a248653'
  end

  factory :ichord, class: User do
    login :ichord
    name :chord
    company :person
    location 'new zealand'
    public_repos 8
    followers 9
    following 11
    avatar_url 'https://secure.gravatar.com/avatar/433967a57ccd76de553af35e01821959?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png'
    gravatar_id '433967a57ccd76de553af35e01821959'
  end
end
