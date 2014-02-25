
require 'nowa_api'
require 'webmock/rspec'

RSpec.configure do |conf|
  conf.color = true
end

def stub_json_get(path, fixture, opts = {})

  if fixture
    fixture_file = File.join(File.dirname(__FILE__), 'fixtures', fixture)

    returns = {
      :body => File.open(fixture_file).read,
      :headers => { :content_type => "application/json; charset=utf-8" }
    }
  else
    returns = {
      :body => '',
      :headers => { :content_type => "" }
    } 
  end

  opts[:endpoint] = Ingenia::Api.endpoint unless opts.has_key? :endpoint

  url = URI.parse('http://' + opts[:endpoint] + path)

  if opts.has_key? :auth_token
    url.user = opts[:auth_token] 
    url.password = ''
  end

  url.query = "api_version=1.0"

  stub_request(:get, url.to_s).to_return(returns) 
end

def stub_json_put(path, fixture, opts = {})

  if fixture
    fixture_file = File.join(File.dirname(__FILE__), 'fixtures', fixture)

    returns = {
      :body => File.open(fixture_file).read,
      :headers => { :content_type => "application/json; charset=utf-8" }
    }
  else
    returns = {
      :body => '',
      :headers => { :content_type => "" }
    }
  end

  opts[:endpoint] = Ingenia::Api.endpoint unless opts.has_key? :endpoint

  url = URI.parse('http://' + opts[:endpoint] + path)

  if opts.has_key? :auth_token
    url.user = opts[:auth_token] 
    url.password = ''
  end

  stub_request(:put, url.to_s).to_return(returns) 
end

