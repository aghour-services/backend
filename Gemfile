# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'activestorage-cloudinary-service'
gem 'avo', source: 'https://packager.dev/avo-hq/'
gem 'bootsnap', '>= 1.4.4'
gem 'bootstrap', '~> 5.3.1'
gem 'cloudinary'
gem 'dartsass-rails', '~> 0.4.0'
gem 'devise', '~> 4.8'
gem 'fcm'
gem 'httparty'
gem 'importmap-rails'
gem 'jbuilder', '~> 2.7'
gem 'jquery-rails'
gem 'net-imap' # for rspec
gem 'net-pop'  # for rspec
gem 'net-smtp' # to send email
gem 'newrelic_rpm'
gem 'pg', '~> 1.1'
gem 'pg_search'
gem 'puma', '~> 6.4'
gem 'rails', '~> 7.1.2'
gem 'ransack'
gem 'redis', '~> 4.2.5'
gem 'sassc-rails', '~> 2.1.2'
gem 'sprockets-rails'
gem 'webrick'

group :development, :test do
  gem 'byebug', platforms: %I[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'shoulda-matchers'
  gem 'webmock'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
group :test do
  gem 'database_cleaner-active_record'
  gem 'simplecov', require: false
end
gem 'tzinfo-data', platforms: %I[mingw mswin x64_mingw jruby]
