source 'http://rubygems.org'

gem 'rails', '3.2.6'
gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'feedzirra', '0.2.0.rc2'
gem 'redis'
gem 'haml', "~> 3.1.6"
gem 'spine-rails'
gem 'ruby-haml-js'
gem 'devise'
gem 'omniauth-github'
gem 'settingslogic'
gem 'less-rails-bootstrap'
gem 'octokit'
gem 'seedbank'
gem 'daemons-rails'
gem 'whenever', :require => false
gem 'delayed_job_active_record'
gem 'exception_notification'
gem 'letter_opener'
gem 'roadie'
gem 'redcarpet'

group :production do
  gem 'pg'
end

group :development, :test do
  unless ENV['TRAVIS']
    gem "awesome_print", require: 'ap'
  end
  gem "factory_girl"
  gem "factory_girl_rails"
  gem 'sqlite3'
end

group :development do
  gem "haml-rails"
  gem 'rvm-capistrano', "~> 1.1.0", require: 'capistrano'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem "rspec-rails"
  gem 'database_cleaner'
  gem 'spork'
  gem 'timecop'
end
