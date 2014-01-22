$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'nowa_api'

#
# Setup
#
# Set API key to the test user for this gem
Nowa::Api.api_key = "API_KEY"

require 'irb'
ARGV.clear
IRB.start