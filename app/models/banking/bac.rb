# frozen_string_literal: true

module Banking
  class Bac
    class << self
      URI = ENV['BAC_URI']
      BODY = ENV['BAC_BODY_REQUEST']

      def exchange_rate
        @exchange_rate ||= api_client.fetch!
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
