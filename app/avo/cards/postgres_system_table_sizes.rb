# frozen_string_literal: true

# Card to show sizes of Postgres system tables.
class Avo::Cards::PostgresSystemTableSizes < Avo::Cards::PartialCard
  include PostgresCardHelper

  self.id             = "postgres_system_table_sizes"
  self.label          = "System Table Sizes"
  self.partial        = "avo/cards/postgres_table_sizes"
  self.display_header = true
  self.cols           = 3
  # self.rows = 1

  def data
    @data ||=
      begin
        tmp = connection.select_all(table_sizes_query, "table_sizes").to_a || []
        tmp.reject! { |row| row["table_schema"] == "public" }
        tmp[0..max_records]
      end
  end
end
