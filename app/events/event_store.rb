# frozen_string_literal: true

class EventStore < RailsEventStore::Client
  class << self
    def instance
      event_store = Thread.current[:event_store]

      event_store_class_reloaded = (event_store.class.object_id != EventStore.object_id)

      if event_store.nil? || event_store_class_reloaded
        event_store = EventStore.new
        Thread.current[:event_store] = event_store
      end

      event_store
    end

    def publish(klass, data)
      instance.publish(klass.new(data: data))
    end
  end

  def initialize
    super

    subscribe EventHandlers::Tweet, to: [
      Events::ExchangeRate::Synced
    ]
  end
end
