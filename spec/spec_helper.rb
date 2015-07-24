# encoding: UTF-8

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'expert'
Expert.environment.require_all

require 'rspec'
require 'spec/test_helpers'
require 'rosette/core'
require 'rosette/queuing/sidekiq-queue'
require 'pry-nav'

RSpec.configure do |config|
end
