# frozen_string_literal: true

desc 'Start la faena 🤠'
namespace :exchange_rate do
  task kick: :environment do |_task, _args|
    Delayed::Job.enqueue ExchangeRateSync.new(Banking::Bac)
  end
end
