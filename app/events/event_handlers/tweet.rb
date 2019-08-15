# frozen_string_literal: true

module EventHandlers
  class Tweet
    def call(event)
      @data = event.data

      Tweetter.update(tweet: tweet)
    end

    private

    attr_reader :data

    def tweet
      "Update: #{type} #{verb} #{difference} colones.\n" \
      "Valor actual: #{amount}.\n" + '#tipodecambio $crc $usd'
    end

    def type
      data[:category] == 'sell' ? 'Venta' : 'Compra'
    end

    def verb
      data[:from] < data[:to] ? 'sube' : 'baja'
    end

    def difference
      (data[:from] - data[:to]).abs
    end

    def amount
      data[:to]
    end
  end
end
