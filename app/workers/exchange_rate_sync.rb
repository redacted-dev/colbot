# frozen_string_literal: true

class ExchangeRateSync
  def initialize(bank)
    @bank = bank
  end

  def perform
    ExchangeRateCommands::Sync.call(resource: bank)
  end

  def after
    Delayed::Job.enqueue ::ExchangeRateSync.new(Banking::Bac), queue: 'exchangerate_sync'
  end

  def max_attempts
    3
  end

  def max_run_time
    10
  end

  def destroy_failed_jobs?
    false
  end

  def queue_name
    'exchangerate_sync'
  end

  def reschedule_at(current_time, _attempts)
    current_time + 60.seconds
  end

  def error(job, exception)
    #//TODO sentry
  end

  def failure(job)
    #// TODO sentry
  end

  private

  attr_reader :bank
end
