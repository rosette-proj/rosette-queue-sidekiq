# encoding: UTF-8

require 'spec_helper'

include Rosette::Queuing::SidekiqQueue

describe JobWrapper do
  let(:job) { JobWrapper.new }
  let(:rosette_config) do
    Rosette.build_config do |config|
      config.use_error_reporter(Rosette::Core::BufferedErrorReporter.new)
    end
  end

  before(:each) do
    JobWrapper.rosette_config = rosette_config
  end

  describe '#perform' do
    it 'instantiates the job by class and calls its #work method' do
      expect(rosette_config).to receive(:signal)
      job.perform('klass' => TestJob.name, 'args' => ['arg1', 'arg2'])
    end
  end
end
