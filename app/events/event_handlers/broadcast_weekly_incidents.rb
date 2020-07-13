# frozen_string_literal: true

module EventHandlers
  class BroadcastWeeklyIncidents
    TIMEZONE = 'America/Costa_Rica'

    HISTORIC_START_DATE = 3.weeks.ago.in_time_zone(TIMEZONE).beginning_of_day
    HISTORIC_END_DATE = 2.weeks.ago.in_time_zone(TIMEZONE).beginning_of_day - 1.day

    CURRENT_START_DATE = 2.weeks.ago.in_time_zone(TIMEZONE).beginning_of_day
    CURRENT_END_DATE = 1.week.ago.in_time_zone(TIMEZONE).beginning_of_day - 1.day

    def call(event)
      @data = event.data

      Slacker.update(message: message)
      Tweetter.update(tweet: message, bot: 'WACHI_TW')
    end

    private

    def message
      message = header
      message += body

      message
    end

    def header
      format = '%d/%m'

      "#GAM #PJCR:\n#{HISTORIC_START_DATE.strftime(format)} al #{HISTORIC_END_DATE.strftime(format)} vs " \
      "#{CURRENT_START_DATE.strftime(format)} al #{CURRENT_END_DATE.strftime(format)}\n\n" \
    end

    def body
      text = ''
      historic_categories = historic_records
                            .order(incident: :asc)
                            .select(:incident)
                            .distinct
                            .map(&:incident)

      historic_categories.each do |incident|
        text += "#{incident}: #{detail(incident)}\n"
      end

      text += "\n"

      current_categories = current_records
                           .where.not(incident: historic_categories)
                           .order(incident: :asc)
                           .select(:incident).distinct
                           .map(&:incident)

      text += "Nuevos:\n" if current_categories.any?
      current_categories.each do |incident|
        text += "#{incident}: #{current_records.where(incident: incident).sum(:amount)}\n"
      end

      text
    end

    def detail(incident)
      historic_amount = historic_records.where(incident: incident).sum(:amount).to_f
      current_amount = current_records.where(incident: incident).sum(:amount).to_f

      if current_amount.positive?
        percentage = (((current_amount / historic_amount) - 1) * 100).round(2)
        "#{historic_amount.to_i} => #{current_amount.to_i} (#{add_arrow(percentage)}#{percentage.abs}%)"
      else
        "#{historic_amount.to_i} => 0 (-100%)"
      end
    end

    def add_arrow(value)
      return if value.zero?

      value.positive? ? '+' : '-️'
    end

    def historic_records
      @_historic_records ||= Incident.where(
        category: :weekly,
        started_at: HISTORIC_START_DATE,
        ended_at: HISTORIC_END_DATE
      )
    end

    def current_records
      @_current_records ||= Incident.where(category: :weekly,
                                           started_at: CURRENT_START_DATE,
                                           ended_at: CURRENT_END_DATE)
    end
  end
end
