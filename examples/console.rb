$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'ingenia_api'


#
# Setup
#
# Set API key to the test user for this gem
Ingenia::Api.api_key = "API_KEY"

require 'irb'
ARGV.clear
IRB.start