require './helper'

##
# Run a full set of API calls on tag_sets
##


#
# Setup
#
# Set API key to the test user for this gem
require 'nowa_api'
Nowa::Api.api_key = "API_KEY"
Nowa::Api.version = 2.0

##
# Create
#
example "Create" do
  # Create a new tag_set
  @new_test_tag_set = Nowa::TagSet.create(:name => "new tag set name")
  puts "\n created a new tag_set:"
  puts "#{@new_test_tag_set}".green
end


##
# Index
#
example "Index" do
  # Get a list of all your tag_sets
  tag_sets = Nowa::TagSet.all
  puts "got #{tag_sets.length} tag_sets".green

  # Get the first tag_set
  @test_tag_set = tag_sets.first

  puts "\n First TagSet: ".green
  puts "#{@test_tag_set}".green

  @test_tag_set_id = @test_tag_set['id']
  @test_tag_set_name = @test_tag_set['name']
end


##
# Show
#
example "Show" do
  # Get the updated tag_set, including it's text
  @test_tag_set = Nowa::TagSet.get(@test_tag_set_id)
  puts "\n updated tag_set:"
  puts "#{@test_tag_set}".green
end


##
# Update
# 
example "Update" do
  # Update its text
  response = Nowa::TagSet.update(@test_tag_set_id, :name => "updated tag_set name new")
  puts "#{response}".green
end


##
# Destroy
#
example "Destroy" do
  # Remove this new tag_set
  response =  Nowa::TagSet.destroy(@new_test_tag_set['id'])
  puts "#{response}".green
end

