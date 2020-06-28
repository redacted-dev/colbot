# frozen_string_literal: true

desc 'Update incidents from the past day'
namespace :incident do
  task process_daily_update: :environment do |_task, _args|
    cmd = IncidentCommands::ProcessDailyIncidents.call
    Snitcher.snitch(ENV['SNITCH_ENDPOINT'], message: 'Updated incidents.') if cmd.success?
  end
end
