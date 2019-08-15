# frozen_string_literal: true

desc 'Give it a kick 🤠'
namespace :exchange_rate do
  task kick: :environment do |_task, _args|
    cmd = ExchangeRateCommands::Sync.call(resource: Banking::Bac)
    Raven.capture_exception(message: cmd.message, errors: context.errors&.join(', ')) if cmd.failure?
    Rails.logger.log 'Success' if cmd.success?
  end
end
