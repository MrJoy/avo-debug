# frozen_string_literal: true

# Postgres heap (cache) hit count.
class Avo::Cards::PostgresHeapHits < Avo::Cards::MetricCard
  include PostgresCardHelper

  self.id    = "postgres_heap_hits"
  self.label = "Heap Hits"
  self.cols  = 1
  self.rows  = 1
  # self.prefix = ""
  # self.suffix = ""

  def query
    cache_stats = connection
                  .select_all(cache_stats_query, "cache_usage")
                  .to_a
    cache_stats = cache_stats&.first || {}
    result(cache_stats["heap_hits"])
  end
end
