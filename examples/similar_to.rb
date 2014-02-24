require './helper'


# RestClient.log = STDOUT
require 'nowa_api'
Nowa::Api.api_key = "API_KEY"



# similar to text
example "similar to text" do
  response = Nowa::Api.similar_to(:text => "family meals at christmas.")

  puts "#{response}".green
end

# similar to item
example "similar to item" do
  response = Nowa::Api.similar_to :item_id => Nowa::Item.all.first['id']

  puts "#{response}".green
end

# similar to tags
example "similar to tags" do
  response = Nowa::Api.similar_to :tag_ids => [ 1, 3, 5 ]
  
  puts "#{response}".green
end
