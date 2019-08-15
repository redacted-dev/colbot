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
      "#tipodecambio #{type} #{verb} #{difference} $crc.\n" \
      "Valor actual: #{amount}.\n" + '#bacapp'
    end

    def type
      data[:category] == 'sell' ? 'venta' : 'compra'
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
