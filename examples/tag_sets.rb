$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'nowa_api'

##
# Run a full set of CRUD operations on tag_sets
##

#
# Setup
#
# Set API key to the test user for this gem
Nowa::Api.api_key = "BqKmvP28TypbssvDyQFq"

# Get a list of all your tag_sets
tag_sets = Nowa::TagSet.all(:full_text => true)
puts "got #{tag_sets.length} tag_sets"

# Get the first tag_set
test_tag_set = tag_sets.first

puts "\n\n\n First TagSet: "
puts test_tag_set

test_tag_set_id = test_tag_set['id']


# Update its text
Nowa::TagSet.update(test_tag_set_id, "updated tag_set name")


# Get the updated tag_set, including it's text
test_tag_set = Nowa::TagSet.get(test_tag_set_id)
puts "\n\n\n updated tag_set:"
puts test_tag_set


# Create a new tag_set
new_test_tag_set = Nowa::TagSet.create(test_tag_set['name'] + " new tag_set name")
puts "\n\n\n created a new tag_set:"
puts new_test_tag_set

# Remove this new tag_set
puts "\n\n\ removed the new tag_set:"
puts Nowa::TagSet.destroy(new_test_tag_set['id'])