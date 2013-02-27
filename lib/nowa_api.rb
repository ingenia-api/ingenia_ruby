
require 'restclient'
require 'json'
require 'nowa_api/remote'

module Nowa
  module Api

    attr_accessor :api_key

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
      verify_response { Remote.post('/classify', :api_key => @api_key, :text => text) }
    end

    def train(text, tags = {})
      debug { "train" }
      if tags.is_a? Array
        verify_response { Remote.post('/train', :api_key => @api_key, :text => text, :tags => tags.to_json) }

      elsif tags.is_a? Hash
        verify_response { Remote.post('/train', :api_key => @api_key, :text => text, :tag_sets => tags.to_json) }

      else
        raise "Nowa::Api.train(text, tags) must be called with tags argument as either an Array or a Hash"
      end
    end

    def trained_tags
      debug { "trained_tags" }
      verify_response { Remote.get('/learnt_tags', :api_key => @api_key) }
    end
    
    def endpoint=(ep)
      debug { "endpoint=#{Remote.endpoint}" }
      Remote.endpoint = ep
    end

    def debug=(dbg)
      @debug = dbg
      debug { "debug is on" }
    end

    private

    def verify_response

      output = yield

      return output['data'] if output['status'] == 'okay'

      raise CallFailed.new( output )
    end

    def debug
      puts "Nowa::Api.debug: #{yield}" if @debug
    end

  end
end
