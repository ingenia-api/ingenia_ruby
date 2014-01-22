
require 'restclient'
require 'json'

require 'nowa_api/remote'
require 'nowa_api/item'
require 'nowa_api/tag'
require 'nowa_api/tag_set'

module Nowa
  module Api

    extend self
    
    class CallFailed < StandardError
      def initialize(output)
        prefix = output['status']
        message = output['message']
        super "#{prefix}: #{message}"
      end
    end

    def classify(text)
      debug { "classify" }
      verify_response { Remote.post('/classify', :api_key => api_key, :text => text) }
    end

    def train(text, tags = {})
      debug { "train" }
      if tags.is_a? Array

        verify_response { Remote.post('/items', :api_key => api_key, :json => { :text => text, :tags => tags }.to_json) }

      elsif tags.is_a? Hash
        verify_response { Remote.post('/items', :api_key => api_key, :json => { :text => text, :tag_sets => tags }.to_json) }

      else
        raise "Nowa::Api.train(text, tags) must be called with tags argument as either an Array or a Hash"
      end
    end

    def similar_to(item_id, limit = 10)
      debug { "similar_to" }
      verify_response { Remote.get("/similar_to/#{item_id}", :api_key => api_key, :limit => limit ) }
    end

    def trained_tags
      debug { "trained_tags" }
      verify_response { Remote.get('/learnt_tags', :api_key => api_key) }
    end
    
    def endpoint=(ep)
      debug { "endpoint=#{Remote.endpoint}" }
      Remote.endpoint = ep
    end

    def api_key=(k)
      debug { "api_key=#{k}" }
      @api_key = k
    end

    def api_key
      raise 'Nowa::Api.api_key not set' if @api_key.nil?
      @api_key
    end

    def debug=(dbg)
      @debug = dbg
      debug { "debug is on" }
    end

    def verify_response
      output = yield
      
      puts output

      return output['data'] if output['status'] == 'okay'

      raise CallFailed.new( output )
    end

    private

    def debug
      puts "Nowa::Api.debug: #{yield}" if @debug
    end

  end
end
