# frozen_string_literal: true

if ENV['SENTRY_DSN']
  Raven.configure do |config|
    config.current_environment = Rails.env
    config.dsn = ENV['SENTRY_DSN']
  end
end
