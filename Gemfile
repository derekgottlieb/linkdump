source "https://rubygems.org"

gem "sinatra", "~> 2.1.0"
gem "json"
gem "activerecord", "~> 6.1.0"
# gem 'activerecord', '~> 6.0.0'
# gem 'activerecord', '~> 5.2.0'
gem "sqlite3"
# versions after 2.0.17 break how we set db config in rake tasks with activerecord pre 6.x
# sadly, there are other config issues I haven't tackled when upgrading to AR 6.x, so we're stuck here
# also, AR 5.x are incompatible with ruby 3
# gem 'sinatra-activerecord', '2.0.17'
gem "sinatra-activerecord"
gem "mechanize"
gem "rake"
gem "puma"
gem "pry"
gem "standard"
gem "webrick"
gem "will_paginate"

group :development do
  gem "lefthook"
  gem "shotgun"
end

group :test do
  gem "rspec"
  gem "rack-test"
end
