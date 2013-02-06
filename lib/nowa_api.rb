
require 'restclient'
require 'json'
require 'nowa_api/remote'

module Nowa
  module Api

    extend self

    def classify(key, text)
      Remote.post(key, '/classify', :text => text)
    end

    def train(key, text, tags = {})
      if tags.is_a? Array
        Remote.post(key, '/train', :text => text, :tags => tags.to_json)
      else
        Remote.post(key, '/train', :text => text, :tag_sets => tags.to_json)
      end
    end

    def classify_file(key, file_path)

      args = Remote.post(
        key, 
        '/extract_text', 
        :auth_token => key,
        :file => File.new(file_path, 'rb'), 
        :endpoint => Remote::PDF_ENDPOINT
      )

      classify key, args['text']

    end

    def trained_tags(key)
      Remote.get(key, '/learnt_tags')
    end
  end
end
