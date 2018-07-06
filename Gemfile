source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'devise', '4.4.3'
gem 'json'
gem 'bootstrap'
gem 'jquery-rails'
gem 'kaminari'
gem 'rsolr'
gem 'rsolr-ext'
gem 'config'
gem 'twitter-bootstrap-rails', :group => :assets

gem 'rails', '~> 5.2.0'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'



gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'rspec-rails'
  gem 'capybara',           '>= 2.15', '< 4.0'
  gem 'rubocop',            '0.57.1', require: false
  gem 'factory_girl_rails', '4.9.0'
  gem 'faker',              '1.8.7'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-yarn'
  gem 'capistrano-rbenv'
  gem 'redis'
end

group :test do
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'

  gem 'shoulda-matchers', '~> 3.1'
  gem 'database_cleaner'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
