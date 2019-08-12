module Banking
  class ExchangeRateSerializer < ActiveModel::Serializer
    include Parser

    attributes :exchange_rate, :buy, :sell

    def exchange_rate
      return if object.exchange_rate.nil?

      parse_bac_response
    end

    def buy
      exchange_rate.first[:buy].to_i * 100
    end

    def sell
      exchange_rate.first[:sell].to_i * 100
    end
  end
end