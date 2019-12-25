# frozen_string_literal: true

module EventHandlers
  class Broadcast
    def call(event)
      @data = event.data

      Slacker.update(message: message)
      # TODO: Fix this. Move to delayed job too
      # Tweetter.update(tweet: message)
    end

    private

    attr_reader :data

    def message
      "#{type} rate #{verb} #{difference} $crc. " \
      "Current: #{amount}.\n"
    end

    def type
      data[:category].capitalize
    end

    def verb
      amount_increase? ? 'increases ' : 'decreases'
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
