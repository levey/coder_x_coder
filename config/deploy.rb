set :application, "coder_x_coder"

role :web, "106.187.89.176"                          # Your HTTP server, Apache/etc
role :app, "106.187.89.176"                          # This may be the same as your `Web` server
role :db,  "106.187.89.176", :primary => true # This is where Rails migrations will run

set :user, "levey"
set :group, "admin"
set :use_sudo, false

set :normalize_asset_timestamps, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/apps/#{application}"

set :repository,  "git@bitbucket.org:levey/coderxcoder.git"
set :branch, "master"
set :scm, :git
ssh_options[:forward_agent] = true
set :git_shallow_clone, 1


set :unicorn_path, "#{deploy_to}/current/config/unicorn.rb"

namespace :deploy do
  task :start, :roles => :app do
    run "cd #{deploy_to}/current/; RAILS_ENV=production unicorn_rails -c #{unicorn_path} -D"
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

task :link_shared_files, :roles => :web do
  run "ln -sf #{deploy_to}/shared/config/*.yml #{deploy_to}/current/config/"
  run "ln -sf #{deploy_to}/shared/config/unicorn.rb #{deploy_to}/current/config/"
  run "ln -s #{deploy_to}/shared/assets #{deploy_to}/current/public/assets"
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

task :mongoid_create_indexes, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake db:mongoid:create_indexes"
end

task :mongoid_migrate_database, :roles => :web do
  run "cd #{deploy_to}/current/; RAILS_ENV=production bundle exec rake db:migrate"
end

after "deploy:finalize_update","deploy:symlink", :init_shared_path, :link_shared_files, :install_gems, :compile_assets, :mongoid_create_indexes, :mongoid_migrate_database


set :default_environment, {
  'PATH' => "/home/levey/.rvm/gems/ruby-1.9.3-p125/bin:/home/levey/.rvm/gems/ruby-1.9.3-p125@global/bin:/home/ruby/.rvm/rubies/ruby-1.9.3-p125/bin:/home/ruby/.rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games",
  'RUBY_VERSION' => 'ruby-1.9.3-p125',
  'GEM_HOME' => '/home/levey/.rvm/gems/ruby-1.9.3-p125',
  'GEM_PATH' => '/home/levey/.rvm/gems/ruby-1.9.3-p125:/home/levey/.rvm/gems/ruby-1.9.3-p125@global'
}

