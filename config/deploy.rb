require "rvm/capistrano"                                 # Load RVM's capistrano plugin.
set :rvm_type, :user                                     # Copy the exact line. I really mean :user here
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")

set :application, "github-friend"

role :web, "www.github-friend.com"                          # Your HTTP server, Apache/etc
role :app, "www.github-friend.com"                          # This may be the same as your `Web` server
role :db,  "www.github-friend.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :repository,  "git://github.com/saberma/github-friend.git"
set :scm, :git
set :deploy_via, :remote_cache # 不要每次都获取全新的repository
set :user, ENV['CAP_USER']
set :use_sudo, false

set :pids_path, "#{shared_path}/pids"

depend :remote, :gem, "bundler", ">=1.0.21" # 可以通过 cap deploy:check 检查依赖情况

namespace :deploy do

  task :start do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.conf.rb -D"
  end

  task :stop do
    run "kill -s QUIT `cat #{pids_path}/unicorn.#{application}.pid`"
  end

  task :restart, roles: :app, except: { no_release: true } do
    run "kill -s USR2 `cat #{pids_path}/unicorn.#{application}.pid`"
  end

  # scp config/{database.yml,app_secret_config.yml,unicorn.conf.rb} github@www.github-friend.com:/u/apps/github-friend/shared/config/
  desc "Symlink shared resources on each release" # 配置文件
  task :symlink_shared, roles: :app do
    %w(database.yml app_secret_config.yml unicorn.conf.rb).each do |secure_file|
      run "ln -nfs #{shared_path}/config/#{secure_file} #{release_path}/config/#{secure_file}"
    end
  end

end

before 'deploy:assets:precompile', 'deploy:symlink_shared'
