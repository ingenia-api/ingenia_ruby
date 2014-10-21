
require 'restclient'
require 'json'

require 'ostruct'

require 'ingenia_api/remote'
require 'ingenia_api/item'
require 'ingenia_api/html_extractor'
require 'ingenia_api/tag'
require 'ingenia_api/tag_set'
require 'ingenia_api/bundle'

module Ingenia
  module Api

    extend self

    API_KNOWN_PARAMS = %w( limit text )

    class CallFailed < StandardError
      def initialize(output)
        prefix = output['status']
        message = output['message']
        super "#{prefix}: #{message}"
      end
    end

    # Status of your app
    def status
      debug { "status" }
      verify_response { Remote.get('/status', :api_key => api_key ) }
    end

    # Classify some text
    def classify(text)
      debug { "classify" }
      verify_response { Remote.post('/classify', :api_key => api_key, :text => text) }
    end

    # Deprecated train action, now creates an item
    def train(text, tags = {})
      debug { "train" }
      if tags.is_a? Array
        Item.create(:json => { :text => text, :tags => tags })

      elsif tags.is_a? Hash
        Item.create(:json => { :text => text, :tag_sets => tags })

      else
        raise "Ingenia::Api.train(text, tags) must be called with tags argument as either an Array or a Hash"
      end
    end

    # Find similar items
    def similar_to( params = {} )
      debug { "similar_to" }

      initialize_params params

      if params.has_key? :text
        verify_response { Remote.post("/similar_to_text", @params ) }
      elsif params.has_key? :tag_ids
        verify_response { Remote.get("/similar_to_tags", @params ) }
      end
    end

    # Summarize some text
    def summarize(params = {})
      debug { "summarize" }
      initialize_params params

      verify_response { Remote.post("/summarise", @params ) }
    end

    def trained_tags
      debug { "trained_tags" }
      verify_response { Remote.get('/learnt_tags', :api_key => api_key) }
    end

    def endpoint=(ep)
      debug { "endpoint=#{Remote.endpoint}" }
      Remote.endpoint = ep
    end

    def version=(v)
      debug { "version=#{Remote.version}" }
      Remote.version = v
    end

    def api_key=(k)
      debug { "api_key=#{k}" }
      @api_key = k
    end

    def api_key
      raise 'Ingenia::Api.api_key not set' if @api_key.nil?
      @api_key
    end

    def debug=(dbg)
      @debug = dbg
      debug { "debug is on" }
    end

    def verify_response
      output = yield

      return output['data'] unless output['data'].nil?

      raise CallFailed.new( output )
    end

    private


      def self.initialize_params( params = {} )
        @params = { :api_key => Ingenia::Api.api_key }.merge!(params)
      end

      def debug
        puts "Ingenia::Api.debug: #{yield}" if @debug
      end

  end
end
