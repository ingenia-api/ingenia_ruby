require './helper'

##
# Run a full set of API calls on tags
##


#
# Setup
#
# Set API key to the test user for this gem
require 'nowa_api'
#local
Nowa::Api.api_key = "YOUR_API_KEY"


##
# Create
#
example "Create" do
  # Get your tag_set
  @tag_set = Nowa::TagSet.all.first

  # Create a new tag
  @new_test_tag = Nowa::Tag.create(:name => "new tag", :tag_set_id => @tag_set['id'])
  puts "\n created a new tag:"
  puts "#{@new_test_tag}".green
end


##
# Index
#
example "Index" do
  # Get a list of all your tags
  tags = Nowa::Tag.all
  puts "got #{tags.length} tags".green

  # Get the first tag
  @test_tag = tags.first

  puts "\n First Tag: ".green
  puts "#{@test_tag}".green

  @test_tag_id = @test_tag['id']
  @test_tag_name = @test_tag['name']
end


##
# Show
#
example "Show" do
  # Get the updated tag, including it's text
  @test_tag = Nowa::Tag.get(@test_tag_id)
  puts "\n updated tag:"
  puts "#{@test_tag}".green
end


##
# Update
# 
example "Update" do
  # Update its text
  response = Nowa::Tag.update(@test_tag_id, :name => "updated tag name new", :description => "this is a testing tag", :tag_set_id => @tag_set['id'])
  puts "#{response}".green
end


##
# Destroy
#
example "Destroy" do
  # Remove this new tag
  response =  Nowa::Tag.destroy(@new_test_tag['id'])
  puts "#{response}".green
end

