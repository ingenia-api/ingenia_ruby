
module Nowa
module Api

  module Remote
    ENDPOINT = 'api.ingeniapi.com'
    API_VERSION = '1.0'

    attr_reader :port

    extend self

    def get(path, opts = {})
      opts[:api_version] ||= API_VERSION
      
      url  = URI::HTTP.build( :host => endpoint, :path => path )
      url.port = port if port
      json = RestClient.get url.to_s, :params => opts
      
      JSON.parse json

    rescue RestClient::BadRequest => e
      if e.response.nil?
        { 'status' => 'error', 'message' => e.to_s }
      else
        JSON.parse e.response
      end

    rescue JSON::ParserError => e
      { 'status' => 'error', 'message' => e.to_s }
    end

    def post(path, opts = {})
      
      opts[:api_version] ||= API_VERSION
      
      url  = URI::HTTP.build( :host => endpoint, :path => path )
      url.port = port if port
      json = RestClient.post url.to_s, opts

      JSON.parse json

    rescue RestClient::BadRequest => e
      if e.response.nil?
        { 'status' => 'error', 'message' => e.to_s }
      else
        JSON.parse e.response
      end

    rescue JSON::ParserError => e
      { 'status' => 'error', 'message' => e.to_s }
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
  end

end
end
