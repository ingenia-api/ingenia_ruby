
require 'spec_helper'

describe Nowa::Api do

  describe '.endpoint' do
    it 'returns default endpoint' do
      Nowa::Api.endpoint.should == 'localhost:3000'
    end

    it 'can be set' do
      Nowa::Api.endpoint = 'foo.com'
      Nowa::Api.endpoint.should == 'foo.com'
      Nowa::Api.endpoint = nil
    end
      
  end

  describe '.status' do
    
    it 'returns status of server' do

      stub_json_get( '/status', 'status.json' )

      res = Nowa::Api.status

      res.has_key?('report').should be_true
    end
    
  end

end

