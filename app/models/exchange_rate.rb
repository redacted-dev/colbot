# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
  enum category: {
    buy: 'buy',
    sell: 'sell'
  }, _prefix: :category

  validates :category, inclusion: { in: categories.values }

  scope :last_buy, -> { category_buy&.last }
  scope :last_sell, -> { category_sell&.last }
end
