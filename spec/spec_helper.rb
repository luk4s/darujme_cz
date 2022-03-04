require "bundler/setup"
require "darujme_cz"

require 'simplecov'
require 'webmock/rspec'
SimpleCov.start

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  Dir.glob(File.expand_path('support/*.rb', __dir__)).sort.each do |file|
    require file
  end
  config.before(:each) do
    DarujmeCz.config.app_id = "123"
    DarujmeCz.config.app_secret = "abcd"
    DarujmeCz.config.organization_id = "2"
  end
end
