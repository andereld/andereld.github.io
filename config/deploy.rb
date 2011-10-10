require "bundler/capistrano"

set :application, "www.eldhuset.org"
set :user, "www-eldhuset.org"
set :use_sudo, false
server "eldhuset.org", :web, :app, :db, :primary => true
set :port, 2222

set :scm, :git
set :repository,  "set your repository location here"
set :scm_username, "andereld"
set :branch, "master"
set :deploy_via, :remote_cache
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :rails_env, "production"
set :deploy_to, "/home/www-eldhuset.org/app"
set :normalize_asset_timestamps, false
