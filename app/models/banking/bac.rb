# frozen_string_literal: true

module Banking
  class Bac
    class << self
      URI = 'https://www.e-bac.net/sbefx/services/WebServicePublisherMessageSessionService'
      BODY = '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:frm="http://tempuri.org/FRM_WS_MS" xmlns:soapenc="http://schemas.xmlsoap.org/soap/encoding/" xsl:version="1.0" xmlns="http://tempuri.org/FRM_WS_MS"><soap:Header/><soap:Body><frm:SOAP_Domain_Msg><header><operationCode>CANALESMOVILES_Cliente_Tipo_Cambio</operationCode><origin><country>CR</country><channel>SECAN</channel><server>46.212.62.103</server><user></user><token>null</token></origin><target><country>CR</country></target></header></frm:SOAP_Domain_Msg></soap:Body></soap:Envelope>'

      def exchange_rate
        api_client.fetch!
      end

      private

      def api_client
        @api_client ||= ApiClient.new(uri: URI, body: BODY, headers: headers).build
      end

      def headers
        {
          'User-Agent' => 'WSClient Android',
          'Soapaction' => 'https://www.e-bac.net/sbefx/services/WebServicePublisherMessageSessionService',
          'Host' => 'www.e-bac.net'
        }
      end
    end
  end
end
