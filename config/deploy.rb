# config valid only for current version of Capistrano
lock '3.8.2'

require 'etc'

set :application, 'linkdump'
#set :repo_url, 'git@github.com:derekgottlieb/linkdump.git'
set :repo_url, 'https://github.com/derekgottlieb/linkdump.git'
set :tmp_dir, "/tmp/#{Etc.getlogin}" # to deploy on multi-user machines
set :rvm_ruby_version, File.read("#{File.dirname(__FILE__)}/../.ruby-version").strip

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/linkdump.derekgottlieb.com'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'db/linkdump.sqlite3', 'config/config.yml', 'config/database.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :passenger_restart_with_touch, true

# config/deploy.rb

namespace :customs do
  desc "Run Migrations"
  task :migrations do
    on roles(:app) do
      within release_path do
        with rack_env: fetch(:rack_env) do
          execute :rake, "db:migrate"
        end
      end
    end
  end
end

# in the proper time, in my case before `after "deploy", "deploy:restart"`
after "deploy", "customs:migrations"
