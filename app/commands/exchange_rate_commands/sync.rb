# frozen_string_literal: true

module ExchangeRateCommands
  class Sync
    include Interactor
    include Ensure

    delegate :resource, to: :context

    def call
      ensure_context_includes :resource
      return if current[:exchange_rate].nil?

      if buy != current[:buy]
        exchange_buy = new(
          category: categories[:buy],
          amount: current[:buy]
        )

        if exchange_buy.save
          publish_success(:buy)
        else
          context.fail!(message: 'Failed saving record.')
        end
      end

      if sell != current[:sell]
        exchange_sell = new(
          category: categories[:sell],
          amount: current[:sell]
        )

        if exchange_sell.save
          publish_success(:sell)
        else
          context.fail!(message: 'Failed saving record.')
        end
      end
    end

    private

    delegate :new, :categories, to: :ExchangeRate
    delegate :buy, :sell, to: :ExchangeRate, prefix: :exchange_rate

    def current
      @_current ||= Banking::ExchangeRateSerializer.new(resource).as_json
    end

    def sell
      exchange_rate_sell.last&.amount
    end

    def buy
      exchange_rate_buy.last&.amount
    end

    def publish_success(category)
      EventStore.publish(
        Events::ExchangeRate::Synced,
        category: category.to_s,
        from: send(category),
        to: current[category]
      )
    end
  end
end
