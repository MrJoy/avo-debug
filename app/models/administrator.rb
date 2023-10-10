# frozen_string_literal: true

class Administrator < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable
end
