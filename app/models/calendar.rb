# frozen_string_literal: true

class Calendar < ApplicationRecord
  has_many :calendar_instances, dependent: :destroy
  has_many :accounts,           through: :calendar_instances
  has_many :users,              through: :accounts

  def self.ransackable_attributes(_auth = nil) = %w[remote_id type created_at]

  def self.ransackable_associations(_auth = nil) = %w[]
end
