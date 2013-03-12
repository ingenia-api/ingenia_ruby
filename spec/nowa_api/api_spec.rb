require 'spec_helper' 

describe Nowa::Api do

  let( :empty_api_response ) { { 'status' => 'okay', 'data' => {} } }

  before :each do
    Nowa::Api.api_key = '1234'
  end

  describe '::classify' do
    it 'calls remote url properly' do

      Nowa::Api::Remote.should_receive( :post ).
        with( '/classify', :text => 'some text', :api_key => '1234' ).
        and_return( empty_api_response )

      Nowa::Api.classify 'some text'
    end
  end

  describe '::train' do
    it 'calls remote url properly with array tags' do

      Nowa::Api::Remote.should_receive( :post ).
        with( '/train', :text => 'some text', :tags => %w{ some tags }.to_json, :api_key => '1234' ).
        and_return( empty_api_response )

      Nowa::Api.train 'some text', %w{ some tags }
    end

    it 'calls remote url properly with nested tags' do

      tags = {
        :tag_set_1 => %w{ tag1 tag2 tag3 },
        :tag_set_2 => %w{ tag4 tag5 tag6 }
      }

      test_payload = {
        :text => 'some text',
        :tag_sets => tags.to_json,
        :api_key => '1234'
      }

      Nowa::Api::Remote.should_receive( :post ).
        with( '/train', test_payload ).
        and_return( empty_api_response )

      Nowa::Api.train 'some text', tags
    end
  end

  describe '::endpoint' do

    it 'is default' do
      Nowa::Api::Remote.endpoint.should == 'api.ingeniapi.com'
    end

    it 'can be set' do
      Nowa::Api::endpoint = 'hoopla.com'
      Nowa::Api::Remote.endpoint.should == 'hoopla.com'
    end

    it 'can take port numbers' do
      Nowa::Api::endpoint = 'hoopla.com:8080'
      Nowa::Api::Remote.endpoint.should == 'hoopla.com'
      Nowa::Api::Remote.port.should == 8080
    end
  end
  
end


