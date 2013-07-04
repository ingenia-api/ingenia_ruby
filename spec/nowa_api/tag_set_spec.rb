require 'spec_helper' 

describe Nowa::TagSet do
  let( :empty_api_response ) { { 'status' => 'okay', 'data' => {} } }


  describe '#create' do
    it 'calls post' do
      name = "this is a test tagset"

      expected_path = '/tag_sets'
      expected_request = {:json=>"{\"name\":\"#{name}\"}", :api_key=>"1234"}

      Nowa::Api::Remote.should_receive( :post ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Nowa::TagSet.create(name)
    end
  end


  describe '#update' do
    it 'calls put' do
      name = "this is an updated test tagset"

      expected_path = '/tag_sets/1'
      expected_request = {:json=>"{\"name\":\"#{name}\"}", :api_key=>"1234"}

      Nowa::Api::Remote.should_receive( :put ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Nowa::TagSet.update(1, name)
    end
  end

  describe '#get' do
    it 'calls get' do
      expected_path = '/tag_sets/1'
      expected_request = { :api_key=>"1234" }

      Nowa::Api::Remote.should_receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Nowa::TagSet.get(1)
    end
  end

  describe '#all' do
    it 'calls get' do
      expected_path = '/tag_sets'
      expected_request = { :offset => 0, :limit => 50, :api_key=>"1234" }

      Nowa::Api::Remote.should_receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Nowa::TagSet.all
    end
  end

  describe '#delete' do
    it 'calls delete' do
      expected_path = '/tag_sets/1'
      expected_request = {:params=>{:api_key=>"1234"}} 

      Nowa::Api::Remote.should_receive( :delete ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Nowa::TagSet.destroy(1)
    end
  end
end


