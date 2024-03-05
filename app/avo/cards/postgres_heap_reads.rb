# frozen_string_literal: true

# Postgres heap (cache) read count.
class Avo::Cards::PostgresHeapReads < Avo::Cards::MetricCard
  include PostgresCardHelper

  self.id    = "postgres_heap_reads"
  self.label = "Heap Reads"
  self.cols  = 1
  self.rows  = 1
  # self.prefix = ""
  # self.suffix = ""

  def query
    cache_stats = connection
                  .select_all(cache_stats_query, "cache_usage")
                  .to_a
    cache_stats = cache_stats&.first || {}
    result(cache_stats["heap_reads"])
  end
end
