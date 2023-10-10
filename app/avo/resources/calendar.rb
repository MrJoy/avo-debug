# frozen_string_literal: true

# Admin resource for user GoogleCalendars.
class Avo::Resources::Calendar < Avo::BaseResource
  def fields
    field(:id, as: :id)

    field(:calendar_instances, as: :has_many, discreet_pagination: true)
  end
end
