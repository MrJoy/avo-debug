# frozen_string_literal: true

# Card to show failed online index rebuilds.
class Avo::Cards::PostgresBrokenIndexes < Avo::Cards::PartialCard
  include PostgresCardHelper

  self.id             = "postgres_broken_indexes"
  self.label          = "Broken Indexes"
  self.partial        = "avo/cards/postgres_broken_indexes"
  self.display_header = true
  self.cols           = 3
  # self.rows = 1

  def data
    @data ||= connection.select_all(invalid_indexes_query, "broken_idx").to_a || []
  end
end
