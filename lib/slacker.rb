# frozen_string_literal: true

class Slacker
  class << self
    def client
      Slack::Notifier.new ENV['SLACK_WEBHOOK']
    end

    def update(message: nil)
      return if message.nil?

      client.ping message
    end
  end
end
