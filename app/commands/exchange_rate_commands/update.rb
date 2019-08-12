# frozen_string_literal: true

module ExchangeRateCommands
  class Update
    include Interactor
    include Ensure

    delegate :resource, to: :context

    def call
      ensure_context_includes :resource

      if ExchangeRate.type_buy.last != online_exchange_rate[:buy]
        Rails.logger.info online_exchange_rate[:buy]
      end

      if ExchangeRate.type_sell.last != online_exchange_rate[:sell]
        Rails.logger.info online_exchange_rate[:sell]
      end
    end

    def online_exchange_rate
      @_online_exchange_rate ||= Banking::ExchangeRateSerializer.new(resource).as_json
    end
  end
end