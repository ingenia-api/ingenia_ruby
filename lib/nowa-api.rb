
require 'open-uri'
require 'json'

load_list = %w{ 
  version 
  knowledge_item 
  user 
  exceptions
}

load_list.each do |mod|
  require "nowa-api/#{mod}"
end

module Nowa
  module Api
    # Your code goes here...
    #

    def self.status
    end
  end
end
