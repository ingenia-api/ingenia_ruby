
require 'open-uri'
require 'json'

load_list = %w{ 
  version 
  knowledge_item 
  user 
  exceptions
  remote_session
}

load_list.each do |mod|
  require "nowa-api/#{mod}"
end

module Nowa
  module Api

    DEFAULT_ENDPOINT = 'http://localhost.com:3000'

    extend self

    def status
      RemoteSession.get_json('/status')
    end

    def endpoint
      @endpoint || DEFAULT_ENDPOINT
    end
    
    def endpoint=(ep)
      @endpoint = ep
    end
                  
  end
end
