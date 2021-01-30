require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require "./app"
  end
end

task :console do
  require "./app"
  require "pry"
  Pry.start
end
