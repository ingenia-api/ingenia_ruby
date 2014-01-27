$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'colorize'
require 'rest_client'

# log rest client activity
# RestClient.log = STDOUT


def example title
  puts "|| #{title} ||\n".yellow

  yield

  puts "\n\n"
end