[![Build Status](https://travis-ci.org/rosette-proj/rosette-queue-sidekiq.svg)](https://travis-ci.org/rosette-proj/rosette-queue-sidekiq) [![Code Climate](https://codeclimate.com/github/rosette-proj/rosette-queue-sidekiq/badges/gpa.svg)](https://codeclimate.com/github/rosette-proj/rosette-queue-sidekiq) [![Test Coverage](https://codeclimate.com/github/rosette-proj/rosette-queue-sidekiq/badges/coverage.svg)](https://codeclimate.com/github/rosette-proj/rosette-queue-sidekiq/coverage)

rosette-queue-sidekiq
====================

Wraps the Sidekiq queuing library and allows Rosette jobs to be enqeued and monitored.

## Installation

`gem install rosette-queue-sidekiq`

Then, somewhere in your project:

```ruby
require 'rosette/queuing/sidekiq-queue'
```

### Introduction

This library is generally meant to be used with the Rosette internationalization platform that extracts translatable phrases from git repositories. rosette-queue-sidekiq is capable of processing Rosette jobs on a Sidekiq queue. It offers a way to enqueue jobs, start up workers to process them, and monitor them via Sidekiq's web interface.

### Usage with rosette-server

Let's assume you're configuring an instance of [`Rosette::Server`](https://github.com/rosette-proj/rosette-server). Adding Sidekiq support would cause your configuration to look something like this:

```ruby
# config.ru
require 'rosette/core'
require 'rosette/queuing/sidekiq-queue'

rosette_config = Rosette.build_config do |config|
  config.use_queue('sidekiq')
end

server = Rosette::Server::ApiV1.new(rosette_config)
run server
```

You can also add Sidekiq web interface support to monitor and control jobs:

```ruby
builder = Rosette::Server::Builder.new
server = Rosette::Server::ApiV1.new(rosette_config)

builder.mount('/', api_server)
builder.mount('/sidekiq', Sidekiq::Web)

run builder.to_app
```

You may want to protect your Sidekiq web interface from outsiders. Here's a quick-n-dirty way to do it with HTTP basic auth:

```ruby
sidekiq_server = Rack::Builder.new do
  map '/' do
    use(Rack::Auth::Basic, "Protected Area") do |username, password|
      allowed_username = ENV['RESQUE_WEB_USERNAME']
      allowed_password = ENV['RESQUE_WEB_PASSWORD']
      username == allowed_username && password == allowed_password
    end

    run Sidekiq::Web
  end
end

builder = Rosette::Server::Builder.new
server = Rosette::Server::ApiV1.new(rosette_config)

builder.mount('/', api_server)
builder.mount('/sidekiq', sidekiq_server)

run builder.to_app
```

## Requirements

This project must be run under jRuby. It uses [expert](https://github.com/camertron/expert) to manage java dependencies via Maven. Run `bundle exec expert install` in the project root to download and install java dependencies.

## Running Tests

`bundle exec rake` or `bundle exec rspec` should do the trick.

## Authors

* Cameron C. Dutro: http://github.com/camertron
