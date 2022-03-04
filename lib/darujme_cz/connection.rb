require 'json'
require 'rest-client'
require 'uri'

module DarujmeCz
  class Connection
    URL = "https://www.darujme.cz/api/v1"

    # @param [String] app_id
    # @param [String] api_key
    def initialize(app_id:, api_key:)
      @app_id = app_id
      @api_key = api_key
    end

    # @param [String] path
    # @param [Hash] params
    def get(path, params = {})
      begin
        response = RestClient.get "#{URL}/#{path}", params: { apiId: @app_id, apiSecret: @api_key }.merge(params)
      rescue RestClient::Exception => e
        handle_response_error(e)
      end
      parse_response(response)
    end

    def post(path, data = {})
      # @todo
      raise NotImplementedError
    end

    private

    # @param [RestClient::Exception] exception
    # @raise [RestClient::Exception]
    def handle_response_error(exception)
      data = parse_response(exception.response)
      exception.message += "\n#{data['message']}"
      raise exception
    end

    def parse_response(response)
      JSON.parse(response.body)
    rescue JSON::ParserError => _e
      {}
    end
  end
end
