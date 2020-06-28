# frozen_string_literal: true

class Incident < ApplicationRecord
  validates :amount, presence: true
  validates :incident, presence: true
  validates :victim, presence: true
end
