require 'spec_helper'

describe Ingenia::HtmlExtractor do
  let( :empty_api_response ) { { 'status' => 'okay', 'data' => {} } }


  describe '#fetch' do
    it 'calls fetch' do
      expected_path = '/html_extractor/fetch'
      expected_request = { :api_key=>"1234", :url=>'http://test.com/url' }

      expect(Ingenia::Api::Remote).to receive( :get ).
        with( expected_path, expected_request).
        and_return( empty_api_response )

      described_class.fetch(url: 'http://test.com/url')
    end

    describe 'url validation' do
      it 'raise an error when not url param passed' do
        expect {
          described_class.fetch({})
        }.to raise_error(described_class::MissingUrl)
      end
    end
  end
end


