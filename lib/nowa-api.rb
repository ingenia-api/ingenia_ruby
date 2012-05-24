
require 'restclient'
require 'json'
require 'nowa-api/remote'

module Nowa
  module Api

    extend self

    def status
      Remote.get(nil, '/status')
    end

    def classify(key, text)
      Remote.put(key, '/api/knowledge_items.json', :text => text)
    end

    def learn(key, text, tags = {})
      Remote.put(key, '/api/knowledge_items.json', :text => text, :tags => tags.to_json)
    end
  end
end
