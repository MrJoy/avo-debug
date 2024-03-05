# frozen_string_literal: true

# Card to show apparently-unused indexes.
class Avo::Cards::PostgresUnusedIndexes < Avo::Cards::PartialCard
  include PostgresCardHelper

  self.id             = "postgres_unused_indexes"
  self.label          = "Unused Indexes"
  self.partial        = "avo/cards/postgres_unused_indexes"
  self.display_header = true
  self.cols           = 3
  # self.rows = 1

  def data
    @data ||= connection.select_all(unused_indexes_query, "broken_idx").to_a || []
  end
end
