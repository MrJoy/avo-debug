# frozen_string_literal: true

# Card to show sizes of our tables.
class Avo::Cards::PostgresApplicationTableSizes < Avo::Cards::PartialCard
  include PostgresCardHelper

  self.id             = "postgres_application_table_sizes"
  self.label          = "Application Table Sizes"
  self.partial        = "avo/cards/postgres_table_sizes"
  self.display_header = true
  self.cols           = 3
  # self.rows = 1

  def data
    @data ||=
      begin
        tmp = connection.select_all(table_sizes_query, "table_sizes").to_a || []
        tmp.select! { |row| row["table_schema"] == "public" }
        tmp[0..max_records]
      end
  end
end
