# frozen_string_literal: true

module EventHandlers
  class BroadcastIncidents
    TIMEZONE = 'America/Costa_Rica'

    def call(event)
      @data = event.data

      Slacker.update(message: message)
    end

    private

    def message
      message = "Daily incidents update:\n"
      Incident.where(created_at: today.beginning_of_day..today.end_of_day).each do |incident|
        message += I18n.t('incident.message', amount: incident.amount, victim: incident.victim, incident: incident.incident)
        message += "\n"
      end

      message
    end

    def today
      @_today = Time.now.in_time_zone(TIMEZONE)
    end
  end
end
