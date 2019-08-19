# frozen_string_literal: true

class RootController < ApplicationController
  def index
    render json: [last_buy, last_sell]
  end

  def last_buy
    @last_buy ||= ExchangeRatePresenter.present(ExchangeRate.buy.last)
  end

  def last_sell
    @last_sell ||= ExchangeRatePresenter.present(ExchangeRate.sell.last)
  end
end
