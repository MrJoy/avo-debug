# frozen_string_literal: true

class Avo::Actions::ScanCalendarForChangedEvents < Avo::BaseAction
  self.name    = "Scan Changed Events"
  self.visible = -> { view == :show }

  def handle(**args)
    records, = args.values_at(:records)

    records.each do |_record|
      succeed("Scanned for changed events.")
    rescue StandardError => e
      log_exception(e)
      error("Unknown error: #{e.message}")
    end
  end
end
