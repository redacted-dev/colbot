# frozen_string_literal: true

module IncidentCommands
  class ProcessDailyIncidents
    include Interactor
    include Ensure

    TIMEZONE = 'America/Costa_Rica'

    def call
      return if Incident.where(created_at: today.beginning_of_day..today.end_of_day).any?

      latest_data.each do |incident|
        incident = Incident.new(
          incident: incident['TC_Delito'],
          victim: incident['TC_Victima'],
          amount: incident['TN_Cantidad']
        )

        context.fail!(message: 'Failed saving incident aggregate') unless incident.save
      end

      
    end

    private

    def latest_data
      JSON.parse(client.fetch!)
    end

    def client
      Incident.api_client
    end

    def today
      Time.now.in_time_zone(TIMEZONE)
    end
  end
end
