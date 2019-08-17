# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'active_model_serializers'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'daemons'
gem 'delayed_job_active_record'
gem 'interactor', '~> 3.0'
gem 'jbuilder', '~> 2.7'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.0'
gem 'rails_event_store'
gem 'sentry-raven'
gem 'snitcher'
gem 'twitter'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'figaro'
  gem 'listen'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end
