# frozen_string_literal: true

webpack_urls = Rails.env.development? ? ["http://localhost:3035", "ws://localhost:3035"] : []

SRC_URLS = ([:self, :unsafe_inline] + webpack_urls).compact.freeze

FONT_SRC_URLS    = ([:data] + SRC_URLS).freeze
IMG_SRC_URLS     = ([:data] + SRC_URLS).freeze
SCRIPT_SRC_URLS  = SRC_URLS
STYLE_SRC_URLS   = SRC_URLS
CONNECT_SRC_URLS = ([:data] + SRC_URLS).freeze

Rails.application.config.content_security_policy do |policy|
  policy.default_src(:self)
  policy.font_src(*FONT_SRC_URLS)
  policy.img_src(*IMG_SRC_URLS)
  policy.object_src(:none)
  policy.script_src(*SCRIPT_SRC_URLS)
  policy.style_src(*STYLE_SRC_URLS)
  policy.connect_src(*CONNECT_SRC_URLS)
end

Rails.application.config.middleware.insert_before(0, Rack::Cors) do
  allow do
    origins(["localhost:5000"])

    resource("*", headers: :any, credentials: true, methods: %i[get post delete put patch options head])
  end
end
