require "bundler/capistrano"

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.2-head@www-eldhuset.org'
set :rvm_type, :user  # Don't use system-wide RVM

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

set :rake "rake --trace"

namespace :deploy do
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after "deploy:update_code", "deploy:symlink_shared"
load 'deploy/assets'
