# frozen_string_literal: true

require 'discordrb/webhooks'

class DiscordClient
  class << self
    def client
      Discordrb::Webhooks::Client.new(url: ENV['DISCORD_WEBHOOK_URL'])
    end

    def update(text:)
      client.execute { |builder| builder.content = text }
    end
  end
end
