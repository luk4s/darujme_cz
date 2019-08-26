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
      data = connection(params).get "#{base_path(params)}/#{endpoint}-by-filter", params
      data[endpoint].map { |i| new(i) }
    end

    def self.connection(params = {})
      credentials = params.delete(:connection) || {
        app_id: DarujmeCz.config.app_id,
        api_key: DarujmeCz.config.app_secret
      }
      Connection.new credentials
    end

    def self.base_path(params = {})
      org = params.delete(:organization_id) || DarujmeCz.config.organization_id
      raise ArgumentError, "Missing organization ID" if org.nil?

      "organization/#{org}"
    end

    attr_reader :id

    # @param [Hash] attributes
    def initialize(attributes)
      @source = attributes
    end

    private

    # @param [Array<String>] list
    def self.define_attributes(list)
      list.each do |attribute|
        define_method attribute.underscore do
          @source[attribute]
        end
      end
    end

  end
end
