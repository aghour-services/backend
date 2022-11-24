#!/bin/bash

rm -f tmp/pids/server.pid
rails db:migrate
bundle exec rails s -p 3000 -b '0.0.0.0'
