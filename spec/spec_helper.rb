
require 'nowa-api'
require 'webmock/rspec'

puts 'ALL YOUR SPECS'

def stub_json_get(path, fixture, endpoint = Nowa::Api.endpoint)

  fixture_file = File.join(File.dirname(__FILE__), 'fixtures', fixture)

  returns = {
    :body => File.open(fixture_file).read,
    :headers => {:content_type => "application/json; charset=utf-8"}
  }

  stub_request(:get, endpoint + path).to_return(returns) 
end

