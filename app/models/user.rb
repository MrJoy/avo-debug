# frozen_string_literal: true

class User < ApplicationRecord
  has_many :accounts, dependent: :destroy
  has_many :calendar_instances,
           through: :accounts,
           source:  :calendar_instances
  has_many :calendars, through: :calendar_instances

  def self.ransackable_attributes(_auth = nil) = %i[id email]

  def self.ransackable_associations(_auth = nil) = %i[]
end
