GithubFriend::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[GithubFriend] ",
  :sender_address => %{"notifier" <#{SecretSetting.smtp.username}>},
  :exception_recipients => %W{#{SecretSetting.author.email}}
