# frozen_string_literal: true

class CalendarInstance < ApplicationRecord
  belongs_to :account,  inverse_of: :calendar_instances
  belongs_to :calendar, inverse_of: :calendar_instances

  has_one :user, through: :account
end
