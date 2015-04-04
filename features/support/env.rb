require 'simplecov'
require 'cucumber/rspec/doubles'
SimpleCov.start 'rails'

require 'cucumber/rails'

# Capybara defaults to XPath selectors rather than Webrat's default of CSS3. In
# order to ease the transition to Capybara we set the default here. If you'd
# prefer to use XPath just remove this line and adjust any selectors in your
# steps to use the XPath syntax.
Capybara.default_selector = :css

# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how 
# your application behaves in the production environment, where an error page will 
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

# class ApplicationController < ActionController::Base
#   if Rails.env.test?
#     prepend_before_filter :stub_current_user
#     def stub_current_user
#       puts "stub current user"
#       session[:user_id] = cookies[:stub_user_id] if cookies[:stub_user_id]
#       puts "session id is "
#       puts session[:user_id]
#     end
#   end
# end


# Before('@omniauth_test') do
#   OmniAuth.config.test_mode = true
#   Capybara.default_host = 'http://example.com'

#   OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
#       :provider => 'google_oauth2',
#       :uid => '123545',
#       :info => { :email => 'example@berkeley.edu', 
#       	:name => 'russell' },
#         :credentials => {:token => '1234565', 
#         	:expires_at => 123456789009999}
#       })
#   request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
# end

# After('@omniauth_test') do
#   OmniAuth.config.test_mode = false
# end