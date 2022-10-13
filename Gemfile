# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 6.1.4'

gem 'pg', '~> 1.1'
gem 'pg_search'

gem 'puma', '~> 5.6'

gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.4'

gem 'activestorage-cloudinary-service'
gem 'cloudinary'
gem 'newrelic_rpm'

gem 'devise', '~> 4.8'
gem 'fcm'

gem 'net-imap' # for rspec
gem 'net-pop'  # for rspec
gem 'net-smtp' # to send email
gem 'redis', '~> 4.2.5'

group :development, :test do
  gem 'byebug', platforms: %I[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'faker', '~> 2.15.1'
  gem 'rails-controller-testing', '~> 1.0.5'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'rubocop', '~> 1.19'
  gem 'shoulda-matchers', '~> 4.4.1'
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
