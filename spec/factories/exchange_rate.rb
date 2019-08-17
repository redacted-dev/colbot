# frozen_string_literal: true

FactoryBot.define do
  factory :exchange_rate do
    category
    amount
  end

  trait(:sell) do
    category { ExchangeRate.categories[:sell] }
  end

  trait(:buy) do
    category { ExchangeRate.categories[:buy] }
  end
end
