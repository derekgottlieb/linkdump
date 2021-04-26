# linkdump
Simple link dump Sinatra app (JSON API + basic web views)

[![Build status](https://circleci.com/gh/derekgottlieb/linkdump.svg?style=svg)](https://circleci.com/gh/derekgottlieb/linkdump)
[![Security](https://hakiri.io/github/derekgottlieb/linkdump/master.svg)](https://hakiri.io/github/derekgottlieb/linkdump/master)
[![Code Climate](https://codeclimate.com/github/derekgottlieb/linkdump/badges/gpa.svg)](https://codeclimate.com/github/derekgottlieb/linkdump)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

I use the following Pythonista 3 script to post new links from an iOS device via the Share menu:
https://gist.github.com/derekgottlieb/a077355a4c355301577df93ee9f413f9

## Getting started with development

```
rvm install .
gem install bundler

rvm use .
bundle install

lefthook install # setup git hooks

APP_DIR=$PWD CONSOLE_LOG=1 bundle exec puma
```
