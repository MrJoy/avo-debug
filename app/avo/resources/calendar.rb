# frozen_string_literal: true

# Admin resource for user GoogleCalendars.
class Avo::Resources::Calendar < Avo::BaseResource
  def fields
    field(:id, as: :id)
    field(:remote_id, as: :text, filterable: true)

    field(:calendar_instances, as: :has_many, discreet_pagination: true)
  end
end
