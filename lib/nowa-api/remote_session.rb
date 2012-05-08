
module Nowa
module Api
  
  # i hate ruby http. i mean, wtf guys? sort it out already
  module RemoteSession

    extend self

    def auth_url(auth_token, path)
      return "http://#{Nowa::Api.endpoint}#{path}" if auth_token.nil?
      "http://#{auth_token}:@#{Nowa::Api.endpoint}#{path}"
    end
    
    def self.get_json(path, key = nil, opts = {})
      json = RestClient.get auth_url(key, path)
      JSON.parse json

    rescue JSON::ParserError, RestClient::Exception
      { :status => 'error', :message => $!.to_s }
    end

    def self.put_json(path, key, args = {})
      json = RestClient.put auth_url(key, path), args
      JSON.parse json

    rescue JSON::ParserError, RestClient::Exception
      { :status => 'error', :message => $!.to_s }
    end

    def self.post_json(path, key, args = {})
      json = RestClient.post auth_url(key, path), args
      JSON.parse json

    rescue JSON::ParserError, RestClient::Exception
      { :status => 'error', :message => $!.to_s }
    end

  end

end
end

