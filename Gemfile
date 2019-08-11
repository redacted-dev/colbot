source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'interactor', '~> 3.0'
gem 'jbuilder', '~> 2.7'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0.rc2'
gem 'sqlite3', '~> 1.4'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end