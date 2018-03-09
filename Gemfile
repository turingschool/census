source 'https://rubygems.org'
ruby '2.3.0'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'honeybadger'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem "paperclip", "~> 5.0.0"
gem 'aws-sdk', '~> 2.3'
gem 'active_model_serializers', '~> 0.10.0'
gem 'sprockets', '~> 3.0'
gem 'rb-readline'
gem 'coolline'
gem 'active_designer'

# Production debugging
gem 'rails_12factor', group: :production

# Store environment variables on test/development securely
gem 'figaro'

# User authentication and some authorization
gem 'devise'
gem 'doorkeeper'

# Authorization
gem 'cancancan'

# Styling
gem 'bootstrap-sass'
gem 'rack-cors', require: 'rack/cors'
gem "bootstrap-table-rails"

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'poltergeist'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'simplecov', require: false
  gem 'oauth2' #used to simulate client app in testing
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'brakeman', :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
