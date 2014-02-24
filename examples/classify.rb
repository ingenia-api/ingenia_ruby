
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'nowa_api'

Nowa::Api.api_key = "API_KEY"

# text = <<BIG
# we ate at 7pm straight from a viewing at the cinema. Nice table, nice food, decent service and best of all, good value. Would I go again? Already booked...
# BIG

puts Nowa::Item.all 



# puts RestClient.post('https://api.ingeniapi.com/similar_to_text', :text => text, :api_key => Nowa::Api.api_key)