require './helper'


# RestClient.log = STDOUT
require 'nowa_api'
Ingenia::Api.api_key = "API_KEY"



# similar to text
example "similar to text" do
  response = Ingenia::Api.similar_to(:text => "family meals at christmas.")

  puts "#{response}".green
end

# similar to item
example "similar to item" do
  response = Ingenia::Api.similar_to :item_id => Ingenia::Item.all.first['id']

  puts "#{response}".green
end

# similar to tags
example "similar to tags" do
  response = Ingenia::Api.similar_to :tag_ids => [ 1, 3, 5 ]
  
  puts "#{response}".green
end
