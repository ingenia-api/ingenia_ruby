require 'faraday_middleware'

require 'ingenia/api/client'
require 'ingenia/api/config'

require 'ingenia/api/errors/ingenia_error'

module Ingenia
  # This is the core module of the Ingenia Ruby library.
  # It provides the ability to configure and call common
  # API services.
  #
  module Api
    def self.configure(&block)
      @config = Config.new(&block)
    end

    def self.status(*args)
      client.status(*args)
    end

    def self.classify(*args)
      client.classify(*args)
    end

    def self.train(*args)
      client.train(*args)
    end

    def self.similar_to(*args)
      client.similar_to(*args)
    end

    def self.summarize(*args)
      client.summarize(*args)
    end

    # Require configuration before use
    def self.config
      if @config
        @config
      else
        message = 'No config found. Please run Ingenia::Api.configure'
        fail IngeniaError, message
      end
    end

    def self.client
      @client ||= Client.new(config)
    end
    private_class_method :client
  end
end
