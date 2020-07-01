# frozen_string_literal: true

module EventHandlers
  class BroadcastIncidents
    TIMEZONE = 'America/Costa_Rica'

    def call(event)
      @data = event.data

      Slacker.update(message: message)
      Tweetter.update(tweet: message, bot: 'WACHI_TW')
    end

    private

    def message
      message = "Ayer en el GAM:\n"
      Incident.where(created_at: during_today).order(amount: :desc, victim: :asc).each do |incident|
        message += I18n.t(
          'incident.message',
          amount: incident.amount,
          victim: incident.victim,
          incident: incident.incident
        )
        message += "\n"
      end

      message
    end

    def during_today
      today.beginning_of_day..today.end_of_day
    end

    def today
      @_today = Time.now.in_time_zone(TIMEZONE)
    end
  end
end
