
load_list = %w{ 
  version 
  knowledge_item 
  user 
}

load_list.each do |mod|
  require "nowa-api/#{mod}"
end

module Nowa
  module Api
    # Your code goes here...
  end
end
