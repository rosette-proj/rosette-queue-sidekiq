# encoding: UTF-8

require 'sidekiq'
require 'rosette/queuing'

module Rosette
  module Queuing
    module SidekiqQueue

      autoload :Queue,      'rosette/queuing/sidekiq-queue/queue'
      autoload :Worker,     'rosette/queuing/sidekiq-queue/worker'
      autoload :JobWrapper, 'rosette/queuing/sidekiq-queue/job_wrapper'

    end
  end
end
