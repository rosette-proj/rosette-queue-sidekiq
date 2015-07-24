# encoding: UTF-8

require 'spec_helper'

include Rosette::Queuing::SidekiqQueue

describe Worker do
  let(:logger) { NullLogger.new }

  let(:rosette_config) do
    Rosette.build_config do |config|
      config.use_error_reporter(Rosette::Core::BufferedErrorReporter.new)
    end
  end

  describe '#initialize' do
    it 'assigns job wrapper config' do
      worker = Worker.new(rosette_config, logger)
      expect(JobWrapper.rosette_config).to eq(rosette_config)
      expect(JobWrapper.logger.object_id).to eq(logger.object_id)
    end

    it 'assigns sidekiq and redis config' do
      worker = Worker.new(rosette_config, logger, {
        redis: { foo: :bar }, sidekiq: { foo: :baz }
      })

      expect(Sidekiq.options[:foo]).to eq(:baz)
      expect(Sidekiq.logger.object_id).to eq(logger.object_id)
    end
  end

  describe '#start' do
    let(:worker) { Worker.new(rosette_config, logger) }

    it 'tells sidekiq to start processing jobs' do
      cli_instance = double(:cli)
      allow(Sidekiq::CLI).to receive(:instance).and_return(cli_instance)
      allow(cli_instance).to receive(:load_celluloid)
      expect(cli_instance).to receive(:run)
      worker.start
    end
  end
end
