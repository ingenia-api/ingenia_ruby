require './helper'

require 'nowa_api'
Nowa::Api.api_key = "API_KEY"

# summarise some text
example "summarize" do
  Nowa::Api.summarize :text => "What kind of cheese is the best cheese?"
end


