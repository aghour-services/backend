#!/usr/bin/env bash

bundle install
rm -rf /app/tmp/pids/server.pid

bundle exec rails db:migrate
bundle exec rails s -p 3000 -b '0.0.0.0'
