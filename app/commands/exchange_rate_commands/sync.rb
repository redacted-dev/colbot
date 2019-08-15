# frozen_string_literal: true

module ExchangeRateCommands
  class Sync
    include Interactor
    include Ensure
    include Syncable

    delegate :resource, to: :context

    def call
      ensure_context_includes :resource
      return if current[:exchange_rate].nil?

      validate_synchrony(category: :buy)
      validate_synchrony(category: :sell)
    end

    private

    attr_reader :last_sell, :last_buy

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
        from: colonize(send("last_#{category}")),
        to: colonize(current[category])
      )
    end
  end
end
