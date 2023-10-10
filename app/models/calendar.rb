# frozen_string_literal: true

class Calendar < ApplicationRecord
  has_many :calendar_instances, dependent: :destroy
  has_many :accounts,           through: :calendar_instances
  has_many :users,              through: :accounts
end
