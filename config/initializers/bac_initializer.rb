# frozen_string_literal: true

Delayed::Job.enqueue ::ExchangeRateSync.new(Banking::Bac)
