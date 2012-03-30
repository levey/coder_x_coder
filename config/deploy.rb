
require "bundler/capistrano"

set :scm,             :git
set :repository,      "git@bitbucket.org:levey/coderxcoder.git"
set :branch,          "master"
set :migrate_target,  :current
set :ssh_options,     { :forward_agent => true }
set :rails_env,       "production"
set :deploy_to,       "/home/levey/apps/coder_x_coder"
set :normalize_asset_timestamps, false

set :user,            "levey"
set :runner,          "levey"
set :group,           "admin"
set :use_sudo,        false

role :web,    "106.187.89.176"
role :app,    "106.187.89.176"
role :db,     "106.187.89.176", :primary => true


default_environment["RAILS_ENV"] = 'production'


set :default_environment, {
  'PATH' => "/home/levey/.rvm/gems/ruby-1.9.3-p125/bin:/home/levey/.rvm/gems/ruby-1.9.3-p125@global/bin:/home/levey/.rvm/rubies/ruby-1.9.3-p125/bin:/home/levey/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
  'RUBY_VERSION' => 'ruby-1.9.3-p125',
  'GEM_HOME' => '/home/levey/.rvm/gems/ruby-1.9.3-p125',
  'GEM_PATH' => '/home/levey/.rvm/gems/ruby-1.9.3-p125:/home/levey/.rvm/gems/ruby-1.9.3-p125@global'
}


namespace :deploy do
  task :start, :roles => :app do
    run "cd #{deploy_to}/current/; RAILS_ENV=production unicorn_rails -c  #{deploy_to}/current/config/unicorn.rb -D"
  end

  task :stop, :roles => :app do
    run "kill -QUIT `cat #{deploy_to}/current/tmp/pids/unicorn.pid`"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{deploy_to}/current/tmp/pids/unicorn.pid`"
  end
end



task :init_shared_path, :roles => :web do
  run "mkdir -p #{deploy_to}/shared/log"
  run "mkdir -p #{deploy_to}/shared/pids"
  run "mkdir -p #{deploy_to}/shared/assets"
end


task :restart_resque, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production ./script/resque stop; RAILS_ENV=production ./script/resque start"
end

task :restart_resque, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production ./script/resque stop; RAILS_ENV=production ./script/resque start"
end

task :install_gems, :roles => :web do  	
  run "cd #{deploy_to}/current/; bundle install"	  	
end

task :compile_assets, :roles => :web do	  	
  run "cd #{deploy_to}/current/; bundle exec rake assets:precompile"  	
end

task :migrate_database, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake db:migrate"
end

after "deploy:finalize_update","deploy:symlink", :init_shared_path, :install_gems, :compile_assets, :migrate_database

