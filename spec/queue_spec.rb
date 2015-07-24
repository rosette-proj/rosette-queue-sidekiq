# encoding: UTF-8

require 'spec_helper'

describe Rosette::Queuing::SidekiqQueue::Queue do
  let(:queue) { Rosette::Queuing::SidekiqQueue::Queue.new(nil) }
  let(:job) { TestJob.new('foo', 'bar') }

  describe '#enqueue' do
    it 'enqueues a job with sidekiq' do
      expect(Sidekiq::Client).to receive(:enqueue_to_in).with(
        'testqueue', 0, JobWrapper, {
          'klass' => 'TestJob', 'args' => ['foo', 'bar']
        }
      )

      queue.enqueue(job)
    end

    it 'respects delay' do
      job.set_delay(10)

      expect(Sidekiq::Client).to receive(:enqueue_to_in).with(
        'testqueue', 10, JobWrapper, {
          'klass' => 'TestJob', 'args' => ['foo', 'bar']
        }
      )

      queue.enqueue(job)
    end
  end
end
