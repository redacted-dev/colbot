module Parser
  extend ActiveSupport::Concern

  included do
    #// TODO enhance
    def parse_bac_response
      h = Hash.from_xml(object.exchange_rate)['Envelope']['Body']['SOAP_Domain_Response_Msg']['body']['exchRatesBean']['exchangeRates']['exchRateBean'].second.values.second.values.flatten

      h = h.map do |v|
        if v['multiMapKey'] == 'CR'
          {
              buy: v['buy'],
              sell: v['sell']
          }
        end
      end

      h.compact
    end
  end
end