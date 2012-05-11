
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

      url = auth_url(key, path)
      json = RestClient.get url, :params => { :api_version => Nowa::Api::API_VERSION }
      JSON.parse json

    rescue JSON::ParserError, RestClient::Exception
      puts "failed (#{$!})"
      { :status => 'error', :message => $!.to_s }
    end

    def self.put_json(path, key, args = {})
      args[:api_version] = Nowa::Api::API_VERSION
      json = RestClient.put auth_url(key, path), args
      JSON.parse json

    rescue JSON::ParserError, RestClient::Exception
      { :status => 'error', :message => $!.to_s }
    end

    def self.post_json(path, key, args = {})
      args[:api_version] = Nowa::Api::API_VERSION
      json = RestClient.post auth_url(key, path), args
      JSON.parse json

    rescue JSON::ParserError, RestClient::Exception
      { :status => 'error', :message => $!.to_s }
    end

  end

end
end

