# frozen_string_literal: true

class Incident < ApplicationRecord
  class << self
    TIMEZONE = 'America/Costa_Rica'

    def api_client(**kwargs)
      @start_date = kwargs[:start_date]
      @end_date = kwargs[:end_date]
      ApiClient.new(http_method: :post, uri: ENV['PJ_URL'], body: body, headers: headers).build
    end

    def body
      "{ 'pJson': #{pjson} }"
    end

    # rubocop:disable Metrics/LineLength
    def pjson
      "'{\"TN_FechaInicio\":#{formatted_date(start_date)},\"TN_FechaFinal\":#{formatted_date(end_date)},\"TC_Provincias\":\"2,3,4,1\",\"TC_Cantones\":\"201,205,208,301,302,303,306,307,308,401,402,403,404,405,406,407,408,409,101,102,103,106,107,108,109,110,111,113,114,115,118\",\"TC_Distritos\":\"0\",\"TC_Delito\":\"1,2,3,4,5,6\",\"TC_Victima\":\"1,2,3,4,5\",\"TC_Modalidades\":\"0\"}'"
    end
    # rubocop:enable Metrics/LineLength

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end

    def start_date
      @start_date ||= 1.day.ago
    end

    def end_date
      @end_date ||= 1.day.ago
    end

    def formatted_date(date)
      I18n.l(date.in_time_zone(TIMEZONE), format: :pj)
    end
  end

  enum category: {
    daily: 'daily',
    weekly: 'weekly'
  }, _prefix: :category

  validates :amount, presence: true
  validates :incident, presence: true
  validates :victim, presence: true

  # def halp
  #   {
  #     TN_FechaInicio: I18n.l(1.day.ago, format: :pj),
  #     TN_FechaFinal: I18n.l(1.day.ago, format: :pj),
  #     TC_Provincias: "1",
  #     TC_Cantones: "0",
  #     TC_Distritos: "0",
  #     TC_Delito: "1,2,3,4,5,6",
  #     TC_Victima: "1,2,3,4,5",
  #     TC_Modalidades: "58,59,60,61,62,63,64,65,66,90,91"
  #   }.to_s
  # end
end
