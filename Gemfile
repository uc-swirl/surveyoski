source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.16'

group :development, :test do
  gem 'database_cleaner'
  gem 'cucumber-rails', :require => false
  gem 'sqlite3'
  gem 'ruby-debug19'
  gem 'rspec-rails', '~> 2.14.0'
  gem 'rspec-expectations'
  gem 'simplecov'
  gem 'rake','~> 10.4.2'
  gem 'autotest-rails'
  gem "factory_girl_rails", "~> 4.0"
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'quiet_assets', group: :development
end

group :production do
  gem 'pg'
end

group :assets do
  gem 'uglifier'
  gem 'coffee-rails'
  gem 'sass-rails'
  gem 'therubyracer'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'validates_as_phone_number', '~> 0.7.5'
gem 'devise'
gem 'pundit'
gem 'email_validator', '~> 1.5.0'
gem 'omniauth-google-oauth2', "~> 0.2.1"
gem "codeclimate-test-reporter", group: :test, require: nil
gem 'jquery-ui-rails'
gem 'uuid', '~> 2.3.7'
gem "d3-rails"
gem 'will_paginate', '~> 3.0.5'
gem 'thin'