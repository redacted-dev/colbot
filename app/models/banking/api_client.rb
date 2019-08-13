# frozen_string_literal: true

module Banking
  class ApiClient
    include Helper

    require 'net/http'
    require 'uri'

    CONTENT_TYPE = 'text/xml; charset=utf-8'

    def initialize(uri: nil, body: nil, headers: [])
      @uri = URI.parse(uri)
      @body = body
      @headers = headers
    end

    def build
      request.content_type = CONTENT_TYPE
      request.body = body

      headers.each do |header|
        request[header.first] = header.second
      end

      self
    end

    def fetch!
      response = Net::HTTP.start(uri.hostname, uri.port, request_options) do |http|
        http.request(request)
      end

      response.body if response.code.to_i == 200
    end

    private

    attr_reader :uri, :body, :headers

    def request
      @_request ||= Net::HTTP::Post.new(uri)
    end
  end
end
