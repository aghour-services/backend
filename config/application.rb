# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
Bundler.require(*Rails.groups)
require_relative '../app/middleware/custom_middleware'

module AghourServicesBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.middleware.use CustomMiddleware
    config.public_file_server.enabled = true

    config.i18n.default_locale = :ar
    config.api_only = false
    config.authentication_keys = [:mobile]
  end
end
