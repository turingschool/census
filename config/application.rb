require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Census
  class Application < Rails::Application
    # Set up transactional emails through Postmark
    config.action_mailer.delivery_method = :postmark
    config.action_mailer.postmark_settings = { api_token: Rails.application.secrets.postmark_api_token }

    config.log_tags = [
      :request_id,
      :subdomain,
      ->(req) {
        session_key = (Rails.application.config.session_options || {})[:key]
        session_data = req.cookie_jar.encrypted[session_key] || {}
        user_id = session_data["warden.user.user.key"]&.first&.first || "guest"
        "user: #{user_id.to_s}"
      }
    ]

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end
  end
end
