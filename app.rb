require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'mechanize'
require 'rollbar'
require 'pry'
require 'erb'
require 'will_paginate'
require 'will_paginate/active_record'

# Recursively pull in all our models and routes
Dir.glob(["models/**/*.rb", "routes/**/*.rb"]).each do |file|
  require_relative file
end

CONFIG = YAML.load_file(Dir.pwd + '/config/config.yml')
set :environment, CONFIG.fetch('environment', 'development')
DB_CONFIG = YAML.load_file(Dir.pwd + '/config/database.yml').fetch(Sinatra::Base.environment.to_s)
set :database, DB_CONFIG

configure do
  Rollbar.configure do |config|
    config.access_token = CONFIG['rollbar_access_token']
    config.environment = Sinatra::Base.environment
    config.framework = "Sinatra: #{Sinatra::VERSION}"
    config.root = Dir.pwd
    unless Sinatra::Base.environment == 'production'
      config.enabled = false
    end
  end
end

# Adapter around the default RequestDataExtractor
class RequestDataExtractor
  include Rollbar::RequestDataExtractor
  def from_rack(env)
    extract_request_data_from_rack(env).merge({
      :route => env["PATH_INFO"]
    })
  end
end

error do
  # Send exception info to rollbar
  request_data = RequestDataExtractor.new.from_rack(env)
  Rollbar.error(env['sinatra.error'], request_data)

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
