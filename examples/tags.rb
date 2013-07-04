$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'nowa_api'

##
# Run a full set of CRUD operations on tags
##

#
# Setup
#
# Set API key to the test user for this gem
Nowa::Api.api_key = "BqKmvP28TypbssvDyQFq"

# Get a list of all your tags
tags = Nowa::Tag.all(:full_text => true)
puts "got #{tags.length} tags"

# Get the first tag
test_tag = tags.first

puts "\n\n\n First Tag: "
puts test_tag

test_tag_id = test_tag['id']
tag_set_id = test_tag['tag_set_id']

# Update its text
Nowa::Tag.update(test_tag_id, "updated tag name", tag_set_id)

# Get the updated tag, including it's text
test_tag = Nowa::Tag.get(test_tag_id)
puts "\n\n\n updated tag:"
puts test_tag


# Create a new tag
new_test_tag = Nowa::Tag.create(test_tag['name'] + " new tag name", tag_set_id)
puts "\n\n\n created a new tag:"
puts new_test_tag


# Remove this new tag
puts "\n\n\ removed the new tag:"
puts Nowa::Tag.destroy(new_test_tag['id'])