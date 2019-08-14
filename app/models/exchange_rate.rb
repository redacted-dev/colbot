# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
  enum category: {
    buy: 'buy',
    sell: 'sell'
  }, _prefix: :category

  validates :category, inclusion: { in: categories.values }
  validates :amount, presence: true

  scope :buy, -> { where(category: categories[:buy]) }
  scope :sell, -> { where(category: categories[:sell]) }
end
