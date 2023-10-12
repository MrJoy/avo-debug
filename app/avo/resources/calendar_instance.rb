# frozen_string_literal: true

# Admin resource for user CalendarInstances.
class Avo::Resources::CalendarInstance < Avo::BaseResource
  self.includes = %i[calendar user account]

  def actions
    action(Avo::Actions::ScanCalendarForChangedEvents)
  end

  def fields
    field(:id, as: :id)
    field(:account,
          as:           :text,
          required:     true,
          format_using: lambda { record.account&.email },
          hide_on:      %i[edit])
    field(:user, as: :has_one, sortable: true, required: true, hide_on: %i[edit])
  end
end
