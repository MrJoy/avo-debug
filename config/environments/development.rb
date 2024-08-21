# frozen_string_literal: true

require "active_support/core_ext/integer/time"

# rubocop:disable Layout/LineLength
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.devise = {
    secret_key:       ENV.fetch("DEVISE_SECRET_KEY", "dummy"),
    bcrypt_stretches: 12,
  }

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp", "caching-dev.txt").exist?
    config.action_controller.perform_caching               = true
    config.action_controller.enable_fragment_cache_logging = true
    config.cache_store                                     = :memory_store
  else
    config.action_controller.perform_caching = false
    config.cache_store                       = :null_store
  end


  config.require_master_key               = false
  config.turbo.signed_stream_verifier_key = ENV.fetch("TURBO_STREAM_VERIFIER_KEY", "dummy")

  config.public_file_server.enabled = true
  # rubocop:disable Style/StringHashKeys
  config.public_file_server.headers = {
    "Cache-Control" => "public, max-age=#{1.hour.to_i}",
  }
  # rubocop:enable Style/StringHashKeys

  config.action_mailer.show_previews         = false
  config.action_mailer.perform_caching       = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.smtp_settings         = {
    domain:               "localhost",
    address:              "localhost",
    port:                 1025,
    authentication:       :plain,
    enable_starttls_auto: false,
  }
  config.action_mailer.default_url_options = {
    protocol: "http",
    host:     "localhost",
    port:     ENV.fetch("PORT", 4000),
  }

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.report_deprecations             = true
  config.active_support.deprecation                     = :log
  config.active_support.disallowed_deprecation          = :raise
  config.active_support.disallowed_deprecation_warnings = []

  config.i18n.fallbacks                     = false
  config.i18n.raise_on_missing_translations = true

  # N.B. If changing any logging config, make sure config/initializers/google.rb is kept in sync!
  config.colorize_logging = true
  config.log_level        = :debug
  config.log_tags         = nil
  config.log_formatter    = nil
  logger                  = ActiveSupport::Logger.new($stdout)
  logger.formatter        = config.log_formatter
  config.logger           = ActiveSupport::TaggedLogging.new(logger)

  # config.active_record.encryption.primary_key         = ENV.fetch("AR_ENCRYPTION_PRIMARY_KEY", "")
  # config.active_record.encryption.deterministic_key   = ENV.fetch("AR_ENCRYPTION_DETERMINISTIC_KEY", "")
  # config.active_record.encryption.key_derivation_salt = ENV.fetch("AR_ENCRYPTION_KEY_DERIVATION_SALT", "")
  config.active_record.verbose_query_logs             = true
  config.active_record.dump_schema_after_migration    = true
  config.active_record.migration_error                = :page_load

  config.assets.quiet   = false
  config.assets.compile = true
  # config.asset_host     = ENV.fetch("BACKEND_BASE_URL", "")

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX
  # config.action_dispatch.show_exceptions = true
  # rubocop:disable Style/StringHashKeys
  config.action_dispatch.default_headers = {
    "Referrer-Policy"                   => "strict-origin-when-cross-origin",
    "X-Content-Type-Options"            => "nosniff",
    "X-Frame-Options"                   => "SAMEORIGIN", # Needed for mailer previews.
    "X-Permitted-Cross-Domain-Policies" => "none",
    "X-XSS-Protection"                  => "0", # See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection
  }
  # rubocop:enable Style/StringHashKeys

  config.force_ssl      = false
  config.secure_cookies = false
  # config.ssl_options = {
  #   # redirect: {
  #   #   exclude: ->(request) { request.path =~ %r{^/vital_signs} },
  #   # },
  #   hsts: {
  #     preload:    true,
  #     expires:    1.day, # Short to make iterating faster!  NOT FOR PRODUCTION!
  #     subdomains: true,
  #   },
  # }

  # Highlight code that enqueued background job in logs.
  config.active_job.verbose_enqueue_logs = true

  # Annotate rendered view with file names.
  config.action_view.annotate_rendered_view_with_filenames = true

  # Raise error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true

  config.action_cable.disable_request_forgery_protection = true

  # Apply autocorrection by RuboCop to files generated by `bin/rails generate`.
  config.generators.apply_rubocop_autocorrect_after_generate!

  config.active_storage.service = :local
end
# rubocop:enable Layout/LineLength
