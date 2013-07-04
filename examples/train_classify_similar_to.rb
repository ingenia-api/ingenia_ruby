
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
  # set this only once, module will remember it always
  Nowa::Api.api_key  = 'muzSoTnR7MX1yT66Nsd6'
  Nowa::Api.endpoint = 'localhost:9292'
  Nowa::Api.debug    = true

  # Classify some text
  demo "classify" do
    Nowa::Api.classify "What kind of cheese is the best cheese?"
  end

  # Train text onto the default tagset
  demo "train simple" do
    Nowa::Api.train "I like cheeses", [ 'food', 'preference', 'cheese' ]
  end

  # Train into two specific tagsets
  demo "train complex" do
    Nowa::Api.train "Is it safe to eat cheese from goats?", { :Cookery => [ 'cheese', 'safety' ], :post_type => [ 'question' ] }
  end

  demo "find items similar to your first item" do
    first_item = Nowa::Item.all.first

    puts Nowa::Api.similar_to(first_item['id'])
  end

end

main if $0 == __FILE__
