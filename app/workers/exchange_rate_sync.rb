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
    1
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
    current_time + 5.seconds
  end

  private

  attr_reader :bank
end
