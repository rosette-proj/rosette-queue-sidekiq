$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rosette/queuing/sidekiq-queue/version'

Gem::Specification.new do |s|
  s.name     = "rosette-queue-sidekiq"
  s.version  = ::Rosette::Queuing::SidekiqQueue::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["camertron@gmail.com"]
  s.homepage = "http://github.com/rosette-proj/rosette-queue-sidekiq"

  s.description = s.summary = "A Sidekiq queue backend for Rosette."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true

  s.add_dependency 'sidekiq', '~> 3.0'

  s.require_path = 'lib'
  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "README.md", "Rakefile", "rosette-queue-sidekiq.gemspec"]
end
