
module Nowa
module Api

  module Remote
    ENDPOINT = 'api.ingeniapi.com'
    API_VERSION = '1.0'

    MAX_ATTEMPTS = 3

    attr_reader :port

    extend self

    def get(path, opts = {})
      check_params opts

      handle_request do
        uri = build_uri(path, opts)
        JSON.parse( RestClient.get uri.to_s, :params => opts )
      end
    end


    def post(path, opts = {})
      check_params opts

      handle_request do
        uri = build_uri(path, opts)
        JSON.parse( RestClient.post uri.to_s, opts )
      end
    end

    def put(path, opts = {})
      check_params opts

      handle_request do
        uri = build_uri(path, opts)
        JSON.parse( RestClient.put uri.to_s, opts )
      end
    end

    def delete(path, opts = {})
      handle_request do
        uri = build_uri(path, opts)
        JSON.parse( RestClient.delete uri.to_s, opts )
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
        loop do # until successful
          begin
            return yield
            
          rescue RestClient::RequestFailed => e
            unless e.response.code == 429 # throttling
              return { 'status' => 'error', 'message' => e.to_s }
            end

          rescue RestClient::BadRequest => e
            if e.response.nil?
              return { 'status' => 'error', 'message' => e.to_s }
            else
              return JSON.parse e.response
            end

          rescue RestClient::UnprocessableEntity => e
            return JSON.parse e.response

          rescue JSON::ParserError => e
            return { 'status' => 'error', 'message' => e.to_s }

          end

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
