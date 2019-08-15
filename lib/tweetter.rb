# frozen_string_literal: true

class Tweetter
  class << self
    def client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
        config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
      end
    end

    def update(tweet: nil)
      return if tweet.nil?

      client.update(tweet)
    end
  end
end
