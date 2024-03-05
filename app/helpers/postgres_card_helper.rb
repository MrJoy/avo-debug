# frozen_string_literal: true

# Mix-in to help with cards for the Postgres health dashboards.
#
# N.B. DO NOT use `#squish` on the SQL queries in this module. Doing so will break the queries if
# they have line comments in them!
#
# rubocop:disable Rails/SquishedSQLHeredocs
module PostgresCardHelper # rubocop:disable Metrics/ModuleLength
  def connection = arguments[:connection]

  def migrations_path = arguments[:migrations_path]

  def max_records = 20

  def cache_stats_query = <<-SQL
    SELECT  SUM(heap_blks_read)::bigint AS heap_reads,
            SUM(heap_blks_hit)::bigint  AS heap_hits,
            (SUM(heap_blks_hit) / NULLIF(SUM(heap_blks_hit) + SUM(heap_blks_read), 0))*100 AS ratio
    FROM    pg_statio_user_tables
  SQL

  def unused_indexes_query = <<-SQL
    SELECT    relname AS table,
              indexrelname AS name,
              pg_relation_size(i.indexrelid) AS size,
              idx_scan AS scans,
              idx_tup_read AS tuples_read,
              idx_tup_fetch AS tuples_fetched
    FROM      pg_stat_user_indexes ui
    JOIN      pg_index i ON ui.indexrelid = i.indexrelid
    WHERE NOT indisunique
    AND       idx_scan < 50
    AND       schemaname = 'public'
    AND       indexrelname NOT LIKE 'pg_toast_%'
    ORDER BY  pg_relation_size(i.indexrelid) DESC
    LIMIT     #{max_records}
  SQL

  def invalid_indexes_query = <<-SQL
    SELECT   c.relname as name,
             pg_relation_size(c.oid) AS size
    FROM     pg_index i
    JOIN     pg_class c ON i.indexrelid = c.oid
    WHERE    c.relname LIKE '%_ccnew' -- New index built using REINDEX CONCURRENTLY
    AND NOT  indisvalid               -- In INVALID state
    ORDER BY pg_relation_size(c.oid) DESC
    LIMIT    #{max_records}
  SQL

  def table_sizes_query = <<-SQL
    WITH RECURSIVE
      pg_inherit(inhrelid, inhparent) AS (SELECT inhrelid,
                                                 inhparent
                                          FROM   pg_inherits
                                          UNION
                                          SELECT child.inhrelid,
                                                 parent.inhparent
                                          FROM   pg_inherit child,
                                                 pg_inherits parent
                                          WHERE  child.inhparent = parent.inhrelid),
      pg_inherit_short AS (SELECT *
                           FROM   pg_inherit
                           WHERE  inhparent NOT IN (SELECT inhrelid FROM pg_inherit))
    SELECT   table_schema,
             TABLE_NAME,
             row_estimate::bigint,
             total_bytes::bigint,
             index_bytes::bigint,
             toast_bytes::bigint,
             table_bytes::bigint
    FROM     (SELECT  *,
                      total_bytes - index_bytes - COALESCE(toast_bytes, 0) AS table_bytes
              FROM    (SELECT c.oid,
                              nspname AS table_schema,
                              relname AS TABLE_NAME,
                              SUM(c.reltuples) OVER (partition BY parent) AS row_estimate,
                              SUM(pg_total_relation_size(c.oid)) OVER (partition BY parent)
                                AS total_bytes,
                              SUM(pg_indexes_size(c.oid)) OVER (partition BY parent) AS index_bytes,
                              SUM(pg_total_relation_size(reltoastrelid)) OVER (partition BY parent)
                                AS toast_bytes,
                              parent
                        FROM  (SELECT    pg_class.oid,
                                         reltuples,
                                         relname,
                                         relnamespace,
                                         pg_class.reltoastrelid,
                                         COALESCE(inhparent, pg_class.oid) parent
                               FROM      pg_class
                               LEFT JOIN pg_inherit_short ON inhrelid = oid
                               WHERE     relkind IN ('r', 'p')) c
              LEFT JOIN pg_namespace n ON n.oid = c.relnamespace) a
              WHERE     oid = parent) a
    ORDER BY total_bytes DESC
  SQL

  def partial_index_candidates_query = <<-SQL
    SELECT
        c.oid,
        c.relname AS index,
        pg_size_pretty(pg_relation_size(c.oid)) AS index_size,
        i.indisunique AS unique,
        a.attname AS indexed_column,
        CASE s.null_frac
            WHEN 0 THEN ''
            ELSE to_char(s.null_frac * 100, '999.00%')
        END AS null_frac,
        pg_size_pretty((pg_relation_size(c.oid) * s.null_frac)::bigint) AS expected_saving
        -- Uncomment to include the index definition
        --, ixs.indexdef
    FROM
        pg_class c
        JOIN pg_index i ON i.indexrelid = c.oid
        JOIN pg_attribute a ON a.attrelid = c.oid
        JOIN pg_class c_table ON c_table.oid = i.indrelid
        JOIN pg_indexes ixs ON c.relname = ixs.indexname
        LEFT JOIN pg_stats s ON s.tablename = c_table.relname AND a.attname = s.attname
    WHERE
        NOT i.indisprimary -- Primary key cannot be partial
        AND i.indpred IS NULL -- Exclude already partial indexes
        AND array_length(i.indkey, 1) = 1 -- Exclude composite indexes
        AND pg_relation_size(c.oid) > 10 * 1024 ^ 2 -- Larger than 10MB
    ORDER BY
        pg_relation_size(c.oid) * s.null_frac DESC
  SQL

  def migrations_full_list_query = "SELECT version FROM schema_migrations"

  def migrations_list_query = "SELECT version FROM schema_migrations ORDER BY version DESC LIMIT 20"

  def migrations_count_query = "SELECT COUNT(*) FROM schema_migrations"
end
# rubocop:enable Rails/SquishedSQLHeredocs
