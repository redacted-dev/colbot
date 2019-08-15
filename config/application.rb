# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Colonesapp
  class Application < Rails::Application
    config.load_defaults 6.0

    config.eager_load_paths += %W[
      #{config.root}/lib
    ]

    config.active_job.queue_adapter = :delayed_job
  end
end
