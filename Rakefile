require "sinatra/activerecord/rake"
require "standard/rake"

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
