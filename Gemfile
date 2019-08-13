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
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0.rc2'
gem 'rails_event_store'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'figaro'
  gem 'listen'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end
