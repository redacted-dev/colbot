# frozen_string_literal: true

desc 'Update incidents from the past day'
namespace :incident do
  task process_daily_update: :environment do |_task, _args|
    IncidentCommands::ProcessDailyIncidents.call
  end

  task process_weekly_update: :environment do |_task, _args|
    TIMEZONE = 'America/Costa_Rica'

    cmd = nil # Avoid NameError

    2.times do |n|
      end_date = (n + 1).weeks.ago.in_time_zone(TIMEZONE).beginning_of_day
      start_date = end_date - 1.week

      next if Incident.where(category: :weekly, started_at: start_date, ended_at: end_date).any?

      cmd = IncidentCommands::ProcessWeeklyIncidents.call(start_date: start_date, end_date: end_date)
      abort 'Something went wrong' unless cmd.success?
    end

    publish_weekly_success unless cmd.nil?
  end

  def publish_weekly_success
    EventStore.publish(
      Events::Incident::WeeklyUpdated,
      {}
    )
  end
end
