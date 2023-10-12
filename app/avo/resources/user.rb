# frozen_string_literal: true

class Avo::Resources::User < Avo::BaseResource
  self.title = :email

  def fields
    field(:id, as: :id)

    tabs do
      tab("Calendars") do
        field(:calendars, as: :has_many, through: :accounts, discreet_pagination: true)
      end

      tab("Calendar Instances") do
        field(:calendar_instances, as: :has_many, through: :accounts, discreet_pagination: true)
      end
    end
  end
end
