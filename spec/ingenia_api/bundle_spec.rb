require 'spec_helper'

describe Ingenia::Bundle do
  let( :empty_api_response ) { { 'status' => 'okay', 'data' => {} } }


  describe '#create' do
    it 'calls post' do
      name = "this is a test bundle"

      expected_path = '/bundles'
      expected_request = {:api_key=>"1234", :json=>"{\"name\":\"this is a test bundle\"}"}

      expect(Ingenia::Api::Remote).to receive( :post ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Bundle.create( :name => name )
    end
  end


  describe '#update' do
    it 'calls put' do
      name = "this is an updated test bundle"

      expected_path = '/bundles/1'
      expected_request = { :json=>"{\"name\":\"#{name}\"}", :api_key=>"1234" }

      expect(Ingenia::Api::Remote).to receive( :put ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Bundle.update( 1, :name => name )
    end
  end

  describe '#get' do
    it 'calls get' do
      expected_path = '/bundles/1'
      expected_request = { :api_key=>"1234" }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Bundle.get(1)
    end
  end

  describe '#all' do
    it 'calls get' do
      expected_path = '/bundles'
      expected_request = { :offset => 0, :limit => 50, :api_key=>"1234" }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Bundle.all :offset => 0, :limit => 50
    end
  end

  describe '#delete' do
    it 'calls delete' do
      expected_path = '/bundles/1'
      expected_request = {:params=>{:api_key=>"1234"}}

      expect(Ingenia::Api::Remote).to receive( :delete ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Bundle.destroy(1)
    end
  end
end


