# frozen_string_literal: true

class User < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :calendar_instances,
           through: :accounts,
           source:  :calendar_instances
  has_many :calendars, through: :calendar_instances
end
