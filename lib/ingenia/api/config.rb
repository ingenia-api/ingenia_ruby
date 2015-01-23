module Ingenia
  module Api
    # This class provides configuration options and defaults
    # for initializing your Ingenia API client.
    class Config
      DEFAULT_OPTIONS = {
        adapter:          Faraday.default_adapter,
        api_key:          nil,
        api_endpoint:     'https://',
        user_agent:       "Ingenia Ruby Gem #{Ingenia::Api::VERSION}".freeze
      }.freeze

      def initialize
        @config = {}
        yield self if block_given?
      end

      def [](name)
        @config.fetch(name, DEFAULT_OPTIONS[name])
      end

      def []=(name, val)
        @config[name] = val
      end

      def clone
        Config.new { |config| @config.each { |k, v| config[k] = v } }
      end
    end
  end
end
