
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'nowa-api'

key = 'Fe57r3wyzPLUM4ivjsyL'

puts "#\n# classify\n#"

res = Nowa::Api.classify key, "This is some text to classify"
puts res.to_yaml

puts "#\n# learn\n#"
res = Nowa::Api.learn key, "Learn from this text", [ 'some', 'tags', 'for', 'this', 'text' ]
puts res.to_yaml

puts "#\n# status\n#"
res = Nowa::Api.user_status key
puts res.to_yaml

