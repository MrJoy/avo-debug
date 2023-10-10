# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :user

  has_many :calendar_instances, dependent: :destroy
end
