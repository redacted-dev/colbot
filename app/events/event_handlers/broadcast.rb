# frozen_string_literal: true

module EventHandlers
  class Broadcast
    def call(event)
      @data = event.data

      # TODO: Fix this. Move to delayed job too
      Slacker.update(message: message)
      Tweetter.update(tweet: message)
    end

    private

    attr_reader :data

    def message
      "#{type} #{verb} #{difference} $crc. " \
      "Actual: #{amount}."
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
