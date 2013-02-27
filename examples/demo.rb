
$: << File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'yaml'
require 'nowa_api'

def demo(name)

  puts "\n\n"
  puts "#\n# Nowa::Api.#{name}\n#"

  output = yield

  puts "output:#{output.to_yaml}"

end

def main

  # set this only once, module will remember it always
  Nowa::Api.api_key  = 'VNgUqeyeHZpp6x6p78pp'
  Nowa::Api.endpoint = 'api.test.ingeniapi.com'
  Nowa::Api.debug    = true


  demo "classify" do
    Nowa::Api.classify "This is some text to classify"
  end

  demo "learn" do
    Nowa::Api.train "Learn from this text", [ 'some', 'tags', 'for', 'this', 'text' ]
  end

end

main if $0 == __FILE__

__END__


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
