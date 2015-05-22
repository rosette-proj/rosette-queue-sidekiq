source "https://rubygems.org"

gemspec

ruby '2.0.0', engine: 'jruby', engine_version: '1.7.15'

gem 'rosette-core', github: 'rosette-proj/rosette-core', branch: 'commit_queue'

group :development, :test do
  gem 'pry-nav'
  gem 'rake'
  gem 'jbundler'
end

group :test do
  gem 'rspec'
end
