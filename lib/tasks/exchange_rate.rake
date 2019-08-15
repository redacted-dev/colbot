# frozen_string_literal: true

desc 'Give it a kick 🤠'
namespace :exchange_rate do
  task kick: :environment do |_task, _args|
    cmd = ExchangeRateCommands::Sync.call(resource: Banking::Bac)
    Snitcher.snitch(ENV['SNITCH_ENDPOINT'], message: "Finished task. #{cmd.message if cmd.failure?}")
  end
end
