GithubFriend::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[GithubFriend] ",
  :sender_address => %{"notifier" <#{SecretSetting.author.email}>},
  :exception_recipients => %w{#{SecretSetting.author.email}}
