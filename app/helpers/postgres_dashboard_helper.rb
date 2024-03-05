# frozen_string_literal: true

# Mix-in to help with Postgres health dashboards.
module PostgresDashboardHelper
  def cards
    card(Avo::Cards::PostgresHeapReads, arguments:)
    card(Avo::Cards::PostgresHeapHits, arguments:)
    card(Avo::Cards::PostgresHeapRatio, arguments:)
    card(Avo::Cards::PostgresApplicationTableSizes, arguments:)
    card(Avo::Cards::PostgresSystemTableSizes, arguments:)
    card(Avo::Cards::PostgresBrokenIndexes, arguments:)
    card(Avo::Cards::PostgresUnusedIndexes, arguments:)
    card(Avo::Cards::PostgresPartialIndexCandidates, arguments:)
    card(Avo::Cards::PostgresMigrations, arguments:)
  end
end
