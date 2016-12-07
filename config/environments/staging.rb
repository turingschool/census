# Based on production defaults
require Rails.root.join("config/environments/production")

# Configuration for Devise Action Mailer and Send Grid
config.action_mailer.default_url_options = { host: 'https://census-app-staging.herokuapp.com/' }
config.action_mailer.delivery_method = :smtp
