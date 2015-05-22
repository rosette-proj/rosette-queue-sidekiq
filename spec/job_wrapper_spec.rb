# encoding: UTF-8

require 'spec_helper'

include Rosette::Queuing::SidekiqQueue

describe JobWrapper do
  let(:job) { JobWrapper.new }
  let(:config_double) { double(:config) }

  before(:each) do
    JobWrapper.rosette_config = config_double
  end

  describe '#perform' do
    it 'instantiates the job by class and calls its #work method' do
      expect(config_double).to receive(:signal)
      job.perform('klass' => TestJob.name, 'args' => ['arg1', 'arg2'])
    end
  end
end
