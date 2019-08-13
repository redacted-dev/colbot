# frozen_string_literal: true

module ExchangeRateCommands
  class Sync
    include Interactor
    include Ensure

    delegate :resource, to: :context

    def call
      ensure_context_includes :resource
      return if current[:exchange_rate].nil?

      if last_buy.amount != current[:buy]
        exchange_buy = new(
          category: categories[:buy],
          amount: current[:buy]
        )

        context.fail!(message: 'Failed saving record.') unless exchange_buy.save
      end

      if last_sell.amount != current[:sell]
        exchange_sell = new(
          category: categories[:sell],
          amount: current[:sell]
        )

        context.fail!(message: 'Failed saving record.') unless exchange_sell.save
      end
    end

    private

    delegate :new, :categories, :last_buy, :last_sell, to: :ExchangeRate

    def current
      @_current ||= Banking::ExchangeRateSerializer.new(resource).as_json
    end
  end
end
