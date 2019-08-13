# frozen_string_literal: true

class RootController < ApplicationController
  def index
    render json: [last_buy, last_sell]
  end

  def last_buy
    @_last_buy ||= ExchangeRatePresenter.present(ExchangeRate.last_buy)
  end

  def last_sell
    @_last_sell ||= ExchangeRatePresenter.present(ExchangeRate.last_sell)
  end
end
