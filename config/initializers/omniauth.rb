#Rails.application.config.middleware.use OmniAuth::Builder do
#  #provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
#  provider :github, SecretSetting.oauth.client_id, SecretSetting.oauth.client_secret, scope: "user"
#end
