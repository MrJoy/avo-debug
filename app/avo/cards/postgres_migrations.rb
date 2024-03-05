# frozen_string_literal: true

# Card to show Rails DB migrations and their status.
class Avo::Cards::PostgresMigrations < Avo::Cards::PartialCard
  include PostgresCardHelper

  self.id             = "postgres_migrations"
  self.label          = "Migrations"
  self.partial        = "avo/cards/postgres_migrations"
  self.display_header = true
  self.cols           = 3
  # self.rows = 1

  def data # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/PerceivedComplexity
    @data ||=
      begin
        all_migrations = connection.select_all(migrations_full_list_query, "migrations").to_a || []
        migrations = connection.select_all(migrations_list_query, "migrations").to_a || []
        num_migrations =
          connection.select_all(migrations_count_query).to_a.first["count"].to_i - migrations.length # rubocop:disable Lint/NumberConversion
        migrations_applied = Hash.new { |_, _| false }

        all_migrations.map! do |row|
          migrations_applied[row["version"]] = true
        end

        max_version = ""
        migrations.map! do |row|
          max_version = row["version"] if row["version"] > max_version
          [row["version"], migration_names[row["version"]]]
        end

        migration_files = migration_names.to_a.select { |(tstamp, _)| tstamp > max_version }

        migrations_unified = (migration_files + migrations).uniq(&:first)

        migrations_unified.map! do |(tstamp, name)|
          [tstamp, name, migrations_applied[tstamp]]
        end

        [num_migrations, migrations_unified]
      end
  end

  def migration_names
    @migration_names ||=
      begin
        tmp = {}
        Dir.open(migrations_path) do |dir|
          while (fname = dir.read)
            next unless /^\d+/.match?(fname)

            tstamp, name = fname.split(".").first.split("_", 2)
            tmp[tstamp] = name
          end
        end
        tmp
      end
  end
end
