require './helper'

##
# Run a full set of API calls related to items
##


# Set API key to the test user for this gem
require 'ingenia_api'

Ingenia::Api.api_key = "API_KEY"
Ingenia::Api.version = 2.0
##
# Create/Train
#
# - Creating items with (optional) tags is the same as training.
# - All new items belong to your first bundle unless specified with the bundle_id param
# - If the same text is sent twice, the old record is overwritten unless the 'update_existing' param is set to false
#
example "Create/train" do
  big_text = "I like cake " * 1000
  new_item = Ingenia::Item.create :json => { :text => big_text, :tags => [ 'food', 'cake', 'obsession'] }
  @new_item_id = new_item['id']

  puts "new item: "
  puts "#{new_item}".green

  # Tidy up
  Ingenia::Item.destroy(@new_item_id)

  # request full text response
  big_text = "I like cake " * 1001
  new_item = Ingenia::Item.create :json => { :text => big_text, :tags => [ 'food', 'cake', 'obsession'] }, :full_text => true
  @new_item_id = new_item['id']

  puts "new item with full text: "
  puts "#{new_item}".green


  # create without updating existing
  response = Ingenia::Item.create :json => { :text => new_item['text'], :tags => [ 'not', 'changed' ] }, :update_existing => false
  puts 'unchaged item'
  puts "#{response}".green
end


##
# Index normal
#
example "Index normal" do
  items = Ingenia::Item.all

  puts "got #{items.length} items"
  puts "\n First Item: "
  puts "#{items.first}".green

  @test_item_id = items.first['id']
end

##
# Index full text
#
example "Index full text" do
  items = Ingenia::Item.all(:full_text => "true")

  puts "got #{items.length} items"
  puts "\n First Item: "
  puts "#{items.first}".green

  @test_item_id = items.first['id']
end

##
# Show
#
example "Show" do
  test_item = Ingenia::Item.get(@new_item_id, :full_text => false )
  puts "Quick view: "
  puts "#{test_item}".green

  # Get it with full text
  @test_item = Ingenia::Item.get(@new_item_id, :full_text => true )
  puts "\n Full text view: "
  puts "#{@test_item}".green
end


##
# Update
#
example "Update" do
  response = Ingenia::Item.update(@test_item_id, :json => { :text => "this is some test update text for testing the API" })

  puts "updated item:"
  puts "#{response}".green

  # Update its tags
  response = Ingenia::Item.update(@test_item_id, :json => { :text => "this is some test update text for testing the API", :tags => ['api', 'testing'] })
  puts "#{response}".green
end


##
# Destroy
#
example "Destroy" do
  # Remove this new item
  response = Ingenia::Item.destroy(@test_item_id)
  puts "#{response}".green
end

##
# Similar to - using auto matching
#
example "similar to" do
  response = Ingenia::Item.similar_to(@test_item_id)

  puts "#{response}".green
end
example "similar to - matching on words" do
  response = Ingenia::Item.similar_to(@test_item_id, :words)

  puts "#{response}".green
end
