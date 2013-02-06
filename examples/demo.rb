
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'nowa_api'

key = 'VNgUqeyeHZpp6x6p78pp'

puts "#\n# classify PDF\n#"

count = 0
start_time = Time.now

Dir.glob( './pdf/*.pdf' ).each do |filename|
  puts "=" * 80
  puts "filename: #{filename}"

  res = Nowa::Api.classify_file key, File.join( File.dirname( __FILE__ ), filename )

  outfile = filename.sub( /\.pdf$/, '.json' )

  puts "response: #{outfile}"

  File.open(outfile, 'w').write(res.to_json)

  count += 1
end

end_time = Time.now

puts '=' * 80

puts "Done #{count} in #{end_time - start_time}s (#{count / (end_time - start_time)} docs per second)"

__END__

puts "#\n# classify\n#"

res = Nowa::Api.classify key, "This is some text to classify"
puts res.to_yaml

puts "#\n# learn\n#"
res = Nowa::Api.learn key, "Learn from this text", [ 'some', 'tags', 'for', 'this', 'text' ]
puts res.to_yaml

puts "#\n# status\n#"
res = Nowa::Api.user_status key
puts res.to_yaml

