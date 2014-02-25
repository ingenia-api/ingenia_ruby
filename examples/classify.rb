
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'nowa_api'

Nowa::Api.api_key = "API_KEY"

puts Nowa::Api.classify "What kind of cheese is the best cheese?"