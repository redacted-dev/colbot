class ExchangeRate < ApplicationRecord
  enum type: {
      buy: 'buy',
      sell: 'sell'
  }, _prefix: :type

  validates :type, inclusion: { in: types.values }
end
