
module Nowa
module Api

  module Remote
    ENDPOINT = 'api.ingeniapi.com'
    API_VERSION = '1.0'

    attr_reader :port

    extend self

    def get(path, opts = {})
      check_params opts

      handle_request do
        uri = build_uri(path, opts)

        json = RestClient.get uri.to_s, :params => opts
        
        JSON.parse json
      end
    end

    def post(path, opts = {})
      check_params opts

      handle_request do
        uri = build_uri(path, opts)
        json = RestClient.post uri.to_s, opts

        JSON.parse json
      end
    end

    def put(path, opts = {})
      check_params opts

      handle_request do
        uri = build_uri(path, opts)
        json = RestClient.put uri.to_s, opts
        JSON.parse json
      end
    end

    def delete(path, opts = {})
      check_params opts

      handle_request do
        uri = build_uri(path, opts)
        json = RestClient.delete uri.to_s, opts
        JSON.parse json
      end
    end

    def endpoint=(str)
      if str[ ':' ]
        parts = str.split(':')
        @endpoint = parts[0]
        @port     = parts[1].to_i
        return str
      end

      @endpoint = str
    end

    def endpoint
      @endpoint || ENDPOINT

    end 

    private

    def check_params param_hash
      raise "missing API key" if (not param_hash.has_key?(:api_key)) || param_hash[:api_key].nil? || param_hash[:api_key].length == 0
    end

    def handle_request
      begin

        yield
      
      rescue RestClient::BadRequest => e
        if e.response.nil?
          { 'status' => 'error', 'message' => e.to_s }
        else
          JSON.parse e.response
        end

      rescue RestClient::UnprocessableEntity => e
        JSON.parse e.response

      rescue JSON::ParserError => e
        { 'status' => 'error', 'message' => e.to_s }

      end
    end

    def build_uri(path, opts = {})
      opts[:api_version] ||= API_VERSION
      
      url  = URI::HTTP.build( :host => endpoint, :path => path )
      url.port = port if port

      url
    end

  end

end
end
