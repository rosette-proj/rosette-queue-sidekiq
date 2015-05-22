# encoding: UTF-8

module Rosette
  module Queuing
    module SidekiqQueue

      class Queue < Rosette::Queuing::Queue
        def enqueue(job)
          Sidekiq::Client.enqueue_to_in(
            job.class.queue_name, job.delay, JobWrapper, {
              'klass' => job.class.name, 'args' => job.to_args
            }
          )
        end
      end

    end
  end
end
