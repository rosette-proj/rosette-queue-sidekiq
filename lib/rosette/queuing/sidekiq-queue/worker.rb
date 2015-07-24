# encoding: UTF-8

require 'sidekiq/cli'

module Rosette
  module Queuing
    module SidekiqQueue

      class Worker < Rosette::Queuing::Worker
        attr_reader :rosette_config, :logger

        def initialize(rosette_config, logger, options = {})
          @rosette_config = rosette_config
          @logger = logger

          JobWrapper.rosette_config = rosette_config
          JobWrapper.logger = logger

          Sidekiq.logger = logger
          Sidekiq.redis = options.fetch(:redis, {})
          Sidekiq.options.merge!(options.fetch(:sidekiq, {}))

          # give sidekiq something to require so it doesn't try to require rails
          Sidekiq.options.merge!(
            require: File.expand_path(
              './version.rb', File.dirname(__FILE__)
            )
          )
        end

        def start
          rosette_config.error_reporter.with_error_reporting do
            Sidekiq::CLI.instance.send(:load_celluloid)
            Sidekiq::CLI.instance.run
          end
        end
      end

    end
  end
end
