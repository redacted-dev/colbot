# frozen_string_literal: true

class Incident < ApplicationRecord
  class << self
    TIMEZONE = 'America/Costa_Rica'

    def api_client
      ApiClient.new(http_method: :post, uri: ENV['PJ_URL'], body: body, headers: headers).build
    end

    def body
      "{ 'pJson': #{pjson} }"
    end

    def pjson
      "'{\"TN_FechaInicio\":#{date},\"TN_FechaFinal\":#{date},\"TC_Provincias\":\"1\",\"TC_Cantones\":\"0\",\"TC_Distritos\":\"0\",\"TC_Delito\":\"1,2,3,4,5,6\",\"TC_Victima\":\"1,2,3,4,5\",\"TC_Modalidades\":\"58,59,60,61,62,63,64,65,66,90,91\"}'"
    end

    def headers
      {
        'Content-Type' => 'application/json'
      }
    end

    def date
      I18n.l(1.day.ago.in_time_zone(TIMEZONE), format: :pj)
    end
  end

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
