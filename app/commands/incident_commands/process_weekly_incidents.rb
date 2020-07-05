# frozen_string_literal: true

module IncidentCommands
  class ProcessWeeklyIncidents
    include Interactor
    include Ensure

    delegate :start_date, :end_date, to: :context

    def call
      ensure_context_includes :start_date, :end_date

      data.each do |incident|
        incident = Incident.new(
          incident: incident['TC_Delito'],
          victim: incident['TC_Victima'],
          amount: incident['TN_Cantidad'],
          category: :weekly,
          started_at: start_date,
          ended_at: end_date
        )

        context.fail!(message: 'Failed saving incident aggregate') unless incident.save
      end
    end

    private

    def data
      @_latest_data = JSON.parse(client.fetch!)
    end

    def client
      @_client = Incident.api_client(start_date: start_date, end_date: end_date)
    end
  end
end
