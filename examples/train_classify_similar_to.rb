
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'nowa_api'

def demo(name)
  puts "\n\n"
  puts "#\n# #{name}\n#"

  output = yield

  puts "output:#{output.to_yaml}"
end

def main
  Ingenia::Api.api_key = "API_KEY"
  
  # Classify some text
  demo "classify" do
    Ingenia::Api.classify "What kind of cheese is the best cheese?"
  end

  # Train text onto the default tagset
  demo "train simple" do
    Ingenia::Api.train "I like cheeses", [ 'food', 'preference', 'cheese' ]
  end

  # Train into two specific tagsets
  demo "train complex" do
    Ingenia::Api.train "Is it safe to eat cheese from goats?", { :Cookery => [ 'cheese', 'safety' ], :post_type => [ 'question' ] }
  end

  demo "find items similar to your first item" do
    first_item = Ingenia::Item.all.first

    puts Ingenia::Api.similar_to(:id => first_item['id'])
  end

end

main if $0 == __FILE__
