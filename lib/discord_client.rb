# frozen_string_literal: true

require 'discordrb/webhooks'

class DiscordClient
  class << self
    def client(webhook_url:)
      Discordrb::Webhooks::Client.new(url: webhook_url)
    end

    def update(text:, webhook_url:)
      client(webhook_url: webhook_url).execute { |builder| builder.content = text }
    end
  end
end
