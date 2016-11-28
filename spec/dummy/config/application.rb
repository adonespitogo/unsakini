require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
require "unsakini"

module Dummy
  class Application < Rails::Application
    config.action_mailer.default_url_options = { :host => "localhost:3000" }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_mailer.delivery_method = :letter_opener
  end
end
