#!/bin/sh

echo "Starting app..."

bundle exec rake db:create db:migrate

export CONSOLE_LOG=1
bundle exec puma -C /usr/src/app/config/puma.rb
