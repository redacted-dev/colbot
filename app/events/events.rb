# frozen_string_literal: true

module Events
  module ExchangeRate
    class Synced < RailsEventStore::Event; end
  end

  module Incident
    class Updated < RailsEventStore::Event; end
    class WeeklyUpdated < RailsEventStore::Event; end
  end
end
