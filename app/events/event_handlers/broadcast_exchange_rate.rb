# frozen_string_literal: true

module EventHandlers
  class BroadcastExchangeRate
    def call(event)
      @data = event.data

      Slacker.update(message: message)
      Tweetter.update(tweet: message, bot: 'TWITTER')
      Tweetter.update(tweet: message, bot: 'WACHI_TW')
    end

    private

    attr_reader :data

    def message
      "#{type} #{verb} #{difference} $crc. " \
      "Actual: #{amount}.\n" \
      'BAC $usd'
    end

    def type
      data[:category] == 'sell' ? 'Venta' : 'Compra'
    end

    def verb
      amount_increase? ? 'sube 📈' : 'baja 📉'
    end

    def difference
      (data[:from] - data[:to]).abs
    end

    def amount
      data[:to]
    end

    def amount_increase?
      data[:from] < data[:to]
    end
  end
end
