require 'bundler/setup'
require 'ok2explore'
require 'simplecov'
require './spec/helpers'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)
SimpleCov.start

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.include Helpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.configure do |c|
  c.include Helpers
end
