require 'spec_helper'

describe Ingenia::Item do
  let( :empty_api_response ) { { 'status' => 'okay', 'data' => {} } }


  describe '#create' do
    it 'calls post' do
      text = "this is a test"

      expected_path = '/items'
      expected_request = {:json=>"{\"text\":\"this is a test\"}", :api_key=>"1234"}

      expect(Ingenia::Api::Remote).to receive( :post ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.create(:json => { :text => text })
    end
  end


  describe '#update' do
    it 'calls put' do
      text = "this is some updated text"

      expected_path = '/items/1'
      expected_request = {:json=>"{\"text\":\"this is some updated text\"}", :api_key=>"1234"}

      expect(Ingenia::Api::Remote).to receive( :put ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.update(1, :json => { :text => text })
    end
  end

  describe '#get' do
    it 'calls get' do
      expected_path = '/items/1'
      expected_request = { :api_key=>"1234" }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.get(1)
    end

    it 'calls get for a specific bundle' do
      expected_path = '/items/1'
      expected_request = { :api_key=>"1234", :bundle_id=>257 }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.get(1, :bundle_id => 257)
    end
  end

  describe '#all' do
    it 'calls get for non full text' do
      expected_path = '/items'
      expected_request = { :offset => 0, :limit => 10, :api_key=>"1234" }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.all(:offset => 0, :limit => 10)
    end

    it 'calls get for full text' do
      expected_path = '/items'
      expected_request = { :offset => 0, :limit => 10, :api_key=>"1234", :full_text=>true }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.all(:offset => 0, :limit => 10, :full_text => true)
    end
  end

  describe '#destroy' do
    it 'calls delete' do
      expected_path = '/items/1'
      expected_request = {:params=>{:api_key=>"1234"}}

      expect(Ingenia::Api::Remote).to receive( :delete ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.destroy(1)
    end
  end

  describe '#similar_to' do
    it 'calls similar_to' do

      expected_path = '/items/1/similar_to'
      expected_request = { :api_key => "1234", mode: 'word' }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Item.similar_to(1, :word)
    end
  end

end


