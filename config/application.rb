# frozen_string_literal: true

require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "active_storage/engine"

Bundler.require(*Rails.groups)

Dotenv::Rails.load

module Core
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.avo_key = ENV.fetch("AVO_KEY", nil)

    config.exceptions_app     = routes
    config.message_signer_key = ENV.fetch("MSG_SIGNER_SECRET_KEY", nil)
  end
end

# Rails.autoloaders.log!
