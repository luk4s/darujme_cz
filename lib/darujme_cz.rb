require "darujme_cz/version"
require "active_support/core_ext/string"
require "active_support/configurable"
require "money"
require "ostruct"

module DarujmeCz
  class Error < StandardError; end
  # Your code goes here...
  autoload :Address, "darujme_cz/address"
  autoload :Base, "darujme_cz/base"
  autoload :Connection, "darujme_cz/connection"
  autoload :Donor, "darujme_cz/donor"
  autoload :Pledge, "darujme_cz/pledge"
  autoload :Transaction, "darujme_cz/transaction"

  include ActiveSupport::Configurable
  config_accessor :app_id, :app_secret, :organization_id
end
