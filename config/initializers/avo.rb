# frozen_string_literal: true

Avo.configure do |config|
  config.root_path = "/admin"
  config.home_path = "/admin"
  config.license_key = Rails.configuration.avo_key
  # config.set_context do
  # end

  config.current_user_method = :current_administrator
  config.current_user_resource_name = :administrator

  config.locale = :en
  config.per_page = 48
  config.per_page_steps = [12, 24, 48, 72, 144]
  config.via_per_page = 48
  config.id_links_to_resource = true
  config.app_name = ""
  config.timezone = "Pacific"
  config.currency = "USD"
  config.buttons_on_form_footers = true
  config.main_menu =
    lambda do
      section("Customer Data") do
        resource(:users, label: "Users")

        resource(:calendars, label: "Calendars")
      end

      section("Operations",
              icon:        "heroicons/outline/wrench-screwdriver",
              collapsable: true,
              collapsed:   false) do
        dashboard(:oltp_health, label: "OLTP DB Health")
      end
    end
end

if defined?(Avo::DynamicFilters)
  Avo::DynamicFilters.configure do |config|
    config.button_label = "Advanced filters"
    config.always_expanded = true
  end
end
