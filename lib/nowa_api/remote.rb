
module Nowa
module Api

  module Remote
    ENDPOINT = 'ingeniapi.com'
    API_VERSION = '1.0'

    attr_writer :endpoint 

    extend self

    def get(path, opts = {})
      opts[:api_version] ||= API_VERSION
      
      url  = URI::HTTP.build( :host => endpoint, :path => path )
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

    def endpoint
      @endpoint || ENDPOINT
    end


  end

end
end
