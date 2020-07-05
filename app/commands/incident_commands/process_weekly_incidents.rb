# frozen_string_literal: true

module IncidentCommands
  class ProcessWeeklyIncidents
    include Interactor
    include Ensure

    TIMEZONE = 'America/Costa_Rica'

    def call
      latest_data.each do |incident|
        incident = Incident.new(
            incident: incident['TC_Delito'],
            victim: incident['TC_Victima'],
            amount: incident['TN_Cantidad'],
            type: Incident.types[:weekly]
        )

        context.fail!(message: 'Failed saving incident aggregate') unless incident.save
      end
    end

    private

    def latest_data
      @_latest_data = JSON.parse(client.fetch!)
    end

    def client
      @_client = Incident.api_client
    end

    def today
      @_today = Time.now.in_time_zone(TIMEZONE)
    end
  end
end

