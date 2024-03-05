# frozen_string_literal: true

# Admin resource for user CalendarInstances.
class Avo::Resources::CalendarInstance < Avo::BaseResource
  self.title    = :effective_label
  self.includes = %i[calendar user account]

  self.index_controls = -> {}

  self.row_controls =
    lambda do
      edit_button
    end

  self.show_controls =
    lambda do
      back_button
      actions_list

      edit_button
    end

  self.edit_controls =
    lambda do
      back_button
      save_button
    end

  self.record_selector    = false
  self.visible_on_sidebar = false

  def actions
    action(Avo::Actions::ScanCalendarForChangedEvents)
  end

  def scopes
    scope(Avo::Scopes::Kept)
    scope(Avo::Scopes::Discarded)
  end

  def fields
    field(:id, as: :id, filterable: true)
    field(:effective_label,
          as:         :text,
          only_on:    :index,
          sortable:   true,
          filterable: true)
    field(:account,
          as:           :text,
          required:     true,
          format_using: lambda { record.account&.email },
          hide_on:      %i[edit])
    field(:user,     as: :has_one,    sortable: true,  required: true, hide_on: %i[edit])
    field(:calendar, as: :belongs_to, sortable: false, required: true, hide_on: :forms)

    field(:discarded_at, as: :date_time, hide_on: %i[forms], sortable: true, filterable: true)
  end
end
