email = SecretSetting.author.email
unless Member.find_by_email(email)
  Member.transaction do
    member = Member.create!(
      :email => email,
      :login => SecretSetting.author.login,
      :token => SecretSetting.author.token
    )

    day = member.days.create!(
      :number => 1,
      :published_on => "2012-05-10"
    )

    day.entries.create!([
      {
        :author => "saberma",
        :link => "rails/rails",
        :published_at => "2012-05-10T12:40:25Z",
        :short_id => "ForkEvent/1550818101"
      }, {
        :author => "alexwilliamsca",
        :link => "aphyr/riemann",
        :published_at => "2012-05-10T10:28:08Z",
        :short_id => "WatchEvent/1550818201"
      }, {
        :author => "amiridis",
        :link => "amiridis/amiridis.github.com",
        :published_at => "2012-05-10T09:01:34Z",
        :short_id => "CreateEvent/1550818301"
      }, {
        :author => "saberma",
        :link => "dhh",
        :published_at => "2012-05-10T08:11:52Z",
        :short_id => "FollowEvent/1550818401"
      }
    ])
  end
end
