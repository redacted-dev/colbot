# frozen_string_literal: true

module Events
  module ExchangeRate
    class Synced < RailsEventStore::Event; end
  end
end
