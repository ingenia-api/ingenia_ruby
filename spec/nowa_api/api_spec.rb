require 'spec_helper' 

describe Ingenia::Api do

  let( :empty_api_response ) { { 'status' => 'okay', 'data' => {} } }

  before :each do
    Ingenia::Api.api_key = '1234'
    Ingenia::Api.version = nil
  end

  describe 'versioning' do
    describe '::version' do

      it 'is default' do
        Ingenia::Api::Remote.version.should == 2.0
      end

      it 'can be set' do
        Ingenia::Api::version = 1.0
        Ingenia::Api::Remote.version.should == 1.0
      end
    end

    describe 'path' do
      it 'calls v2 by default' do
        stub_request(:post, "api.ingeniapi.com/v2/classify")
          .to_return( :body => '{"status":"okay","api_version":"1.0","data":{}}', :status => 200 )

        Ingenia::Api.classify 'some text'
      end

      it 'calls without v2 if set to older version' do
        stub_request(:post, "api.ingeniapi.com/classify")
          .to_return( :body => '{"status":"okay","api_version":"1.0","data":{}}', :status => 200 )

        Ingenia::Api.version = 1.0
        Ingenia::Api.classify 'some text'
      end

      it 'calls correctly if set to 2.0' do
        stub_request(:post, "api.ingeniapi.com/v2/classify")
          .to_return( :body => '{"status":"okay","api_version":"1.0","data":{}}', :status => 200 )

        Ingenia::Api.version = 2.0
        Ingenia::Api.classify 'some text'
      end

    end
  end

  describe '::classify' do
    it 'calls remote url properly' do

      Ingenia::Api::Remote.should_receive( :post ).
        with( '/classify', :text => 'some text', :api_key => '1234' ).
        and_return( empty_api_response )

      Ingenia::Api.classify 'some text'
    end
  end

  describe '::train' do
    it 'calls remote url properly with array tags' do

      Ingenia::Api::Remote.should_receive( :post ).
        with( '/items', :json => { :text => 'some text', :tags => %w{ some tags } }.to_json, :api_key => '1234' ).
        and_return( empty_api_response )

      Ingenia::Api.train 'some text', %w{ some tags }
    end

    it 'calls remote url properly with nested tags' do

      tags = {
        :tag_set_1 => %w{ tag1 tag2 tag3 },
        :tag_set_2 => %w{ tag4 tag5 tag6 }
      }

      test_payload = {
        :json => { :text => 'some text', :tag_sets => tags }.to_json,
        :api_key => '1234'
      }

      Ingenia::Api::Remote.should_receive( :post ).
        with( '/items', test_payload ).
        and_return( empty_api_response )

      Ingenia::Api.train 'some text', tags
    end
  end

  describe '::similar_to' do
    it 'calls remote url properly' do

      Ingenia::Api::Remote.should_receive( :get ).
        with( "/similar_to/1", :api_key => '1234', :item_id => 1 ).
        and_return( empty_api_response )

      Ingenia::Api.similar_to :item_id => 1
    end
  end

  describe '::summarize' do
    it 'calls remote url properly' do

      Ingenia::Api::Remote.should_receive( :post ).
        with( "/summarise", :api_key => '1234', :text => "this is some long-winded text" ).
        and_return( empty_api_response )

      Ingenia::Api.summarize :text =>  "this is some long-winded text"
    end
  end


  describe '::endpoint' do

    it 'is default' do
      Ingenia::Api::Remote.endpoint.should == 'api.ingeniapi.com'
    end

    it 'can be set' do
      Ingenia::Api::endpoint = 'hoopla.com'
      Ingenia::Api::Remote.endpoint.should == 'hoopla.com'
    end

    it 'can take port numbers' do
      Ingenia::Api::endpoint = 'hoopla.com:8080'
      Ingenia::Api::Remote.endpoint.should == 'hoopla.com'
      Ingenia::Api::Remote.port.should == 8080
    end
  end

  
end


