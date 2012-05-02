# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# Load RVM's capistrano plugin.    
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.3-rc1@www-eldhuset.org'
set :rvm_type, :user  # Don't use system-wide RVM

require "bundler/capistrano"

set :application, "www.eldhuset.org"
set :user, "www-eldhuset.org"
set :use_sudo, false
server "eldhuset.org", :web, :app, :db, :primary => true
set :port, 2222

set :scm, :git
set :repository,  "git@github.com:andereld/eldhuset.org.git"
set :branch, "master"
set :scm_user, "andereld"
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache

set :rails_env, "production"
set :deploy_to, "/home/www-eldhuset.org/app"
set :normalize_asset_timestamps, false

set :rake, "bundle exec rake --trace"

namespace :deploy do
  desc "Symlink database.yml"
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, :except => { :no_release => true } do
    run "kill -USR2 `cat /tmp/unicorn.www.eldhuset.org.pid`"
  end

  desc "Start unicorn"
  task :start, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, :except => { :no_release => true } do
    run "kill -QUIT `cat /tmp/unicorn.www.eldhuset.org.pid`"
  end
end

after "deploy:update_code", "deploy:symlink_shared"
before "deploy:assets:precompile", "bundle:install"
before "deploy:assets:precompile", "deploy:symlink_shared"
load 'deploy/assets'
