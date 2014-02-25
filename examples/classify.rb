
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'ingenia_api'

Ingenia::Api.api_key = "API_KEY"

puts Ingenia::Api.classify "What kind of cheese is the best cheese?"