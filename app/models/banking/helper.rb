# frozen_string_literal: true

module Banking
  module Helper
    def request_options
      {
        use_ssl: uri.scheme == 'https'
      }
    end
  end
end
