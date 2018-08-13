ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'paperclip/matchers'
require 'cancan/matchers'
require 'capybara/rails'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.raise_server_errors = false

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.include Paperclip::Shoulda::Matchers
end

class RemoteCohort
  attr_reader :id, :name, :start_date, :status

  def initialize(id:, name: "cohort-name", start_date: DateTime.new, status: "open")
    @id = id
    @name = name
    @start_date = start_date
    @status = status
  end
end

def login(user)
  visit root_path
  click_link 'Login'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end
