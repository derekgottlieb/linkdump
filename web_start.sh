#!/bin/sh

echo "Starting app..."

bundle exec rake db:create db:migrate

bundle exec puma -C /usr/src/app/config/puma.rb
