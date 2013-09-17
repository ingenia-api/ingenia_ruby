$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'nowa_api'

##
# Run a full set of CRUD operations on items
##

#
# Setup
#
# Set API key to the test user for this gem
Nowa::Api.api_key = "YOUR_KEY"
Nowa::Api::Remote.endpoint = 'api.ingeniapi.com'

# Get a list of all your items
items = Nowa::Item.all(:full_text => true)
puts "got #{items.length} items"

# Get the first item
test_item = items.first

puts "\n\n\n First Item: "
puts test_item

test_item_id = test_item['id']


# Update its text
Nowa::Item.update(test_item_id, "this is some test update text for testing the API")


# Get the updated item, including it's text
test_item = Nowa::Item.get(test_item_id)
puts "\n\n\n updated item:"
puts test_item


# Create a new item
new_test_item = Nowa::Item.create(test_item['text'] + " new with some changes")
puts "\n\n\n created a new item:"
puts new_test_item

# Remove this new item
puts "\n\n\ removed the new item:"
puts Nowa::Item.destroy(new_test_item['id'])
