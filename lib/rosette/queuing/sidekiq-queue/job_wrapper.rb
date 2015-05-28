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
          job = get_const_chain(options['klass']).new(*options['args'])
          job.work(self.class.rosette_config, self.class.logger)
        end

        private

        # this is necessary because jruby 1.7.x doesn't support namespaced
        # constant lookup, i.e. Foo::Bar::Baz
        def get_const_chain(const_str)
          const_str.split('::').inject(Kernel) do |const, const_chunk|
            const.const_get(const_chunk.to_sym)
          end
        end
      end

    end
  end
end
