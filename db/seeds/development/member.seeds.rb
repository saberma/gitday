email = SecretSetting.member.email
unless Member.find_by_email(email)
  Member.transaction do
    member = Member.create!(
      :email => email,
      :login => SecretSetting.member.login,
      :token => SecretSetting.member.token
    )

    day = member.days.create!(
      :number => 1,
      :published_on => "2012-05-12"
    )

    day.entries.create!([ # all data just for test.
      {
        :author => "tualatrix",
        :link => "rails/rails",
        :published_at => "2012-05-12T12:40:25Z",
        :short_id => "ForkEvent/1550818101"
      }, {
        :author => "huacnlee",
        :link => "twitter/bootstrap",
        :published_at => "2012-05-12T10:28:08Z",
        :short_id => "WatchEvent/1550818201"
      }, {
        :author => "livid",
        :link => "henices/Tcp-DNS-proxy",
        :published_at => "2012-05-12T09:01:34Z",
        :short_id => "CreateEvent/1550818301"
      }, {
        :author => "lgn21st",
        :link => "ashchan",
        :published_at => "2012-05-12T08:11:52Z",
        :short_id => "FollowEvent/1550818401"
      }, { # yours
        :author => "lgn21st",
        :link => "saberma",
        :published_at => "2012-05-12T07:16:32Z",
        :short_id => "FollowEvent/1550818501"
      }, {
        :author => "huacnlee",
        :link => "saberma/shopqi",
        :published_at => "2012-05-12T06:22:39Z",
        :short_id => "WatchEvent/1550818601"
      }, {
        :author => "flyerhzm",
        :link => "saberma/shopqi",
        :published_at => "2012-05-12T05:28:59Z",
        :short_id => "ForkEvent/1550818701"
      }
    ])
  end
end
