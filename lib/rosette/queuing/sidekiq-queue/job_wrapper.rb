# encoding: UTF-8

module Rosette
  module Queuing
    module SidekiqQueue

      class JobWrapper < Rosette::Queuing::Job
        include Sidekiq::Worker

        class << self
          attr_accessor :rosette_config
          attr_accessor :logger
        end

        def perform(options)
          job = Kernel.const_get(options['klass']).new(*options['args'])
          job.work(self.class.rosette_config, self.class.logger)
        end
      end

    end
  end
end
