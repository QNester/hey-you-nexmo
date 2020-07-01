require "bundler/setup"
require 'ffaker'
require 'hey-you'
require 'hey-you-nexmo'
require 'webmock/rspec'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  Kernel.srand config.seed

  # config.filter_run :focus

  config.before do
    HeyYou::Config.instance.instance_variable_set(:@configured, false)
    HeyYou::Config.instance_variable_set(:@configured, false)
    HeyYou::Config.instance.instance_variable_set(:@collection, nil)
    HeyYou::Config.instance.instance_variable_set(:@env_collection, nil)
  end
end
