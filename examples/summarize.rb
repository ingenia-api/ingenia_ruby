require './helper'

require 'nowa_api'
Ingenia::Api.api_key = "API_KEY"

# summarise some text
example "summarize" do
  Ingenia::Api.summarize :text => "What kind of cheese is the best cheese?"
end


