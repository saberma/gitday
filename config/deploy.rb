require "rvm/capistrano"   # Fixed: ERROR: Gem bundler is not installed, run `gem install bundler` first
require "bundler/capistrano"
set :rvm_type, :user                                     # Copy the exact line. I really mean :user here
set :rvm_ruby_string, 'ruby-1.9.3-p194'

set :application, "github-friend"

set :port, ENV['CAP_PORT']
role :web, "www.github-friend.com"                          # Your HTTP server, Apache/etc
role :app, "www.github-friend.com"                          # This may be the same as your `Web` server
role :db,  "www.github-friend.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :repository,  "git://github.com/saberma/github-friend.git"
set :scm, :git
set :deploy_to, "/home/github/apps/github-friend"
set :deploy_via, :remote_cache
set :user, :github
set :use_sudo, false

set :pids_path, "#{shared_path}/pids"

depend :remote, :gem, "bundler", ">=1.0.21"

namespace :deploy do

  task :start do
    run "cd #{current_path} ; RAILS_ENV=production bundle exec unicorn_rails -c config/unicorn.conf.rb -D"
  end

  task :stop do
    run "kill -s QUIT `cat #{pids_path}/unicorn.#{application}.pid`"
  end

  task :restart, roles: :app, except: { no_release: true } do
    run "kill -s USR2 `cat #{pids_path}/unicorn.#{application}.pid`"
  end

  # scp -P $CAP_PORT config/{database.yml,app_secret_config.yml,unicorn.conf.rb} github@www.github-friend.com:/home/github/apps/github-friend/shared/config/
  desc "Symlink shared resources on each release"
  task :symlink_shared, roles: :app do
    %w(database.yml app_secret_config.yml unicorn.conf.rb).each do |secure_file|
      run "ln -nfs #{shared_path}/config/#{secure_file} #{release_path}/config/#{secure_file}"
    end
  end

end

namespace :daemons do

  task :start do
    run "cd #{current_path} ; RAILS_ENV=production bundle exec rake daemon:github:start"
  end

  task :stop do
    run "cd #{current_path} ; RAILS_ENV=production bundle exec rake daemon:github:stop"
  end

  task :restart, roles: :app, except: { no_release: true } do
    stop
    start
  end

end

before 'deploy:assets:precompile', 'deploy:symlink_shared'
after 'deploy:restart', 'daemons:restart'
after 'deploy:start', 'daemons:start'
after 'deploy:stop', 'daemons:stop'
