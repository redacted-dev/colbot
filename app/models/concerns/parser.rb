# frozen_string_literal: true

module Parser
  extend ActiveSupport::Concern

  included do
    # // TODO enhance
    # rubocop:disable Metrics/LineLength
    def parse_bac_response
      h = Hash.from_xml(object.exchange_rate)['Envelope']['Body']['SOAP_Domain_Response_Msg']['body']['exchRatesBean']['exchangeRates']['exchRateBean'].second.values.second.values.flatten

      h = h.map do |v|
        next unless v['multiMapKey'] == 'CR'

        {
          buy: v['buy'],
          sell: v['sell']
        }
      end

      h.compact
    end
    # rubocop:enable Metrics/LineLength
  end
end
