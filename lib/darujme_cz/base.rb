module DarujmeCz
  class Base

    # @abstract Define name of endpoint, which is also name of root element
    def self.endpoint
      raise NotImplementedError
    end

    # @param [Hash] params
    # @option params [Integer] organization_id (nil) ID of organization
    def self.all(**params)
      where params
    end

    def self.where(**params)
      credentials = params.delete(:connection) || {
        app_id: DarujmeCz.config.app_id,
        api_key: DarujmeCz.config.app_secret
      }
      c = Connection.new credentials
      org = params.delete(:organization_id) || DarujmeCz.config.organization_id
      raise ArgumentError, "Missing organization ID" if org.nil?

      data = c.get "organization/#{org}/#{endpoint}-by-filter", params
      data[endpoint].map { |i| new(i) }
    end

    attr_reader :id

    # @param [Hash] attributes
    def initialize(attributes)
      @source = attributes
    end

  end
end