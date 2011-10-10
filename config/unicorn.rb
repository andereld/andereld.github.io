# based on:
# http://ariejan.net/2011/09/14/lighting-fast-zero-downtime-deployments-with-git-capistrano-nginx-and-unicorn

env = ENV["RAILS_ENV"] || "production"

worker_processes 4
pid "/tmp/unicorn.www.eldhuset.org.pid"

listen "/tmp/www.eldhuset.org_rails.socket", :backlog => 64
preload_app true
timeout 30

if env == "production"
  working_directory "/home/www-eldhuset.org/app/current"

  user 'www-eldhuset.org', 'www-eldhuset.org'
  shared_path = "/home/www-eldhuset.org/app/shared"

  stderr_path "#{shared_path}/log/unicorn.stderr.log"
  stdout_path "#{shared_path}/log/unicorn.stdout.log"
end

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "/tmp/unicorn.www.eldhuset.org.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  # the following is *required* for Rails + "preload_app true",
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
