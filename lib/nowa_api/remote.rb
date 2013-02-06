
module Nowa
module Api

  module Remote
    PDF_ENDPOINT = 'ingeniapi.com:8080'
    ENDPOINT = 'ingeniapi.com'
    API_VERSION = '1.0'

    extend self

    def get(key, path, opts = {})
      opts[:api_version] ||= API_VERSION
      json = RestClient.get authorized_url_for(key, path), :params => opts
      JSON.parse json

    rescue RestClient::BadRequest => e
      if e.response.nil?
        { :status => 'error', :message => e.to_s }
      else
        JSON.parse e.response
      end

    rescue JSON::ParserError => e
      { :status => 'error', :message => e.to_s }
    end

    def post(key, path, opts = {})
      
      opts[:api_version] ||= API_VERSION
      json = RestClient.post authorized_url_for(key, path, opts[:endpoint]), opts
      JSON.parse json

    rescue RestClient::BadRequest => e
      if e.response.nil?
        { :status => 'error', :message => e.to_s }
      else
        JSON.parse e.response
      end

    rescue JSON::ParserError => e
      { :status => 'error', :message => e.to_s }
    end

    def endpoint=(s)
      @endpoint = s
    end

    private

    def authorized_url_for(key, path, ep=nil)
      url = 'http://'
      url += "#{key}:@" if key
      url += ep || @endpoint || ENDPOINT
      url += path
    end
  end

end
end
