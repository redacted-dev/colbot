# frozen_string_literal: true

class Tweetter
  class << self
    def client(bot: 'TWITTER')
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["#{bot}_CONSUMER_KEY"]
        config.consumer_secret     = ENV["#{bot}_CONSUMER_SECRET"]
        config.access_token        = ENV["#{bot}_ACCESS_TOKEN"]
        config.access_token_secret = ENV["#{bot}_ACCESS_SECRET"]
      end
    end

    def update(tweet: nil, bot: nil)
      return if tweet.nil?

      client(bot: bot).update(tweet) unless ENV['PANICK_MODE']
    end
  end
end
