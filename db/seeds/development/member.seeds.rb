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
        :author => "huacnlee",
        :link => "huacnlee/easy_captcha",
        :published_at => "2012-05-10T12:40:25Z",
        :short_id => "ForkEvent/1550718605"
      }, {
        :author => "caiwangqin",
        :link => "stefanhafeneger/PushMeBaby",
        :published_at => "2012-05-10T10:28:08Z",
        :short_id => "WatchEvent/1550684062"
      }, {
        :author => "sorrycc",
        :link => "sorrycc/em",
        :published_at => "2012-05-10T09:01:34Z",
        :short_id => "CreateEvent/1550655741"
      }
    ])
  end
end
