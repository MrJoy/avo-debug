# frozen_string_literal: true

# Health dashboard for primary (OLTP) database.
class Avo::Dashboards::OltpHealth < Avo::Dashboards::BaseDashboard
  include PostgresDashboardHelper

  self.id        = "oltp_health"
  self.name      = "Primary (OLTP) DB Health"
  self.grid_cols = 3

  def arguments
    {
      connection:      ApplicationRecord.connection,
      migrations_path: Rails.root.join("db", "migrate"),
    }
  end
end
