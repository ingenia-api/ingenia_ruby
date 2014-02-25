require 'spec_helper' 

describe Ingenia::Tag do
  let( :empty_api_response ) { { 'status' => 'okay', 'data' => {} } }


  describe '#create' do
    it 'calls post' do
      name = "this is a test tag"

      expected_path = '/tags'
      expected_request = {:json=>"{\"name\":\"#{name}\",\"tag_set_id\":1}", :api_key=>"1234"}

      Ingenia::Api::Remote.should_receive( :post ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Tag.create(:name => name, :tag_set_id => 1)
    end
  end


  describe '#update' do
    it 'calls put' do
      name = "this is an updated test tag"

      expected_path = '/tags/1'
      expected_request = {:json=>"{\"name\":\"#{name}\",\"tag_set_id\":1}", :api_key=>"1234"}

      Ingenia::Api::Remote.should_receive( :put ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Tag.update(1, :name => name, :tag_set_id => 1)
    end
  end

  describe '#get' do
    it 'calls get' do
      expected_path = '/tags/1'
      expected_request = { :api_key=>"1234" }

      Ingenia::Api::Remote.should_receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Tag.get(1)
    end
  end

  describe '#all' do
    it 'calls get' do
      expected_path = '/tags'
      expected_request = { :offset => 0, :limit => 50, :api_key=>"1234" }

      Ingenia::Api::Remote.should_receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Tag.all :offset => 0, :limit => 50
    end
  end

  describe '#delete' do
    it 'calls delete' do
      expected_path = '/tags/1'
      expected_request = {:params=>{:api_key=>"1234"}} 

      Ingenia::Api::Remote.should_receive( :delete ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      Ingenia::Tag.destroy(1)
    end
  end
end


