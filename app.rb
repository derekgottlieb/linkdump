require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'mechanize'
#require 'pry'
require 'erb'
require 'will_paginate'
require 'will_paginate/active_record'

# Recursively pull in all our models and routes
Dir.glob(["models/**/*.rb", "routes/**/*.rb"]).each do |file|
  require_relative file
end

CONFIG = YAML.load(ERB.new(File.read(Dir.pwd + '/config/config.yml')).result)
environment = CONFIG.fetch('environment', 'development')
set :environment, environment
DB_CONFIG = YAML.load(ERB.new(File.read(Dir.pwd + '/config/database.yml')).result).fetch(environment)
set :database, DB_CONFIG

error do
  {"code" => 500, "message" => env['sinatra.error']}.to_json
end

helpers do
  def protected!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, 'Not authorized'
  end

  def protected_json!
    return if authorized?
    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, {'code' => 401, 'message' => 'Not authorized'}.to_json
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [CONFIG['auth_username'], CONFIG['auth_password']]
  end
end

before do
  content_type :json
end

get '/' do
  @links = Link.get(params)

  content_type :html
  halt erb :links_index
end

#get '/' do
#  content_type :html
#  send_file './public/index.html'
#end

after do
  # Close the connection after the request is done so that we don't
  # deplete the ActiveRecord connection pool.
  ActiveRecord::Base.connection.close
end
