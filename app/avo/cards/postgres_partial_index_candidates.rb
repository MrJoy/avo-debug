# frozen_string_literal: true

# Card to show candidates for partial indexes.
class Avo::Cards::PostgresPartialIndexCandidates < Avo::Cards::PartialCard
  include PostgresCardHelper

  self.id             = "postgres_partial_index_candidates"
  self.label          = "Partial Index Candidates"
  self.partial        = "avo/cards/postgres_partial_index_candidates"
  self.display_header = true
  self.cols           = 3
  # self.rows = 1

  def data
    @data ||= connection.select_all(partial_index_candidates_query, "partial_candidates").to_a || []
  end
end
