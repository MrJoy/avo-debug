# frozen_string_literal: true

require "active_support/core_ext/integer/time"

# rubocop:disable Layout/LineLength
Rails.application.configure do
  config.devise = {
    secret_key:       ENV.fetch("DEVISE_SECRET_KEY", "dummy"),
    bcrypt_stretches: 12,
  }

  config.avo_key = ENV.fetch("AVO_KEY", nil)

  config.rails_max_threads           = ENV.fetch("RAILS_MAX_THREADS", 4).to_i
  config.cache_classes               = false
  config.eager_load                  = false
  config.consider_all_requests_local = true
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
  config.server_timing = true

  config.action_controller.allow_forgery_protection = true

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

  config.action_view.annotate_rendered_view_with_filenames = true

  # config.action_cable.disable_request_forgery_protection = false

  config.active_storage.service = :local
end
# rubocop:enable Layout/LineLength
