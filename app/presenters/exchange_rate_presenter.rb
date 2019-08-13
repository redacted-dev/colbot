# frozen_string_literal: true

class ExchangeRatePresenter < BasePresenter
  def present(_context)
    {
      tipo: object.category,
      valor: object.amount / 100,
      fecha: object.created_at.to_formatted_s(:db)
    }
  end
end
