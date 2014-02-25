require './helper'

##
# Run a full set of API calls on tags
##


#
# Setup
#
# Set API key to the test user for this gem
require 'ingenia_api'
#local
Ingenia::Api.api_key = "API_KEY"
Ingenia::Api.version = 2.0


##
# Create
#
example "Create" do
  # Get your tag_set
  @tag_set = Ingenia::TagSet.all.first

  # Create a new tag
  @new_test_tag = Ingenia::Tag.create(:name => "new tag", :tag_set_id => @tag_set['id'])
  puts "\n created a new tag:"
  puts "#{@new_test_tag}".green
end


##
# Index
#
example "Index" do
  # Get a list of all your tags
  tags = Ingenia::Tag.all
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
  @test_tag = Ingenia::Tag.get(@test_tag_id)
  puts "\n updated tag:"
  puts "#{@test_tag}".green
end


##
# Update
# 
example "Update" do
  # Update its text
  response = Ingenia::Tag.update(@test_tag_id, :name => "updated tag name new", :description => "this is a testing tag", :tag_set_id => @tag_set['id'])
  puts "#{response}".green
end


##
# Destroy
#
example "Destroy" do
  # Remove this new tag
  response =  Ingenia::Tag.destroy(@new_test_tag['id'])
  puts "#{response}".green
end

