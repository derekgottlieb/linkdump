workers Integer(ENV["WEB_CONCURRENCY"] || 2)
threads_count = Integer(ENV["RAILS_MAX_THREADS"] || 5)
threads threads_count, threads_count

preload_app!

APP_DIR = ENV["APP_DIR"] || "/var/www/linkdump/current"
rackup "config.ru"
port ENV["PORT"] || 3000
environment ENV["RACK_ENV"] || "development"
directory APP_DIR

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end

# If we were preloading the app, might want this
before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

lowlevel_error_handler do |e|
  [500, {}, ["<h1>We need more monkeys!</h1>\n\nAn error has occurred, and engineers have been informed. Please reload the page.\n"]]
end

stdout_redirect "#{APP_DIR}/log/stdout", "#{APP_DIR}/log/stderr", true unless ENV["CONSOLE_LOG"]
