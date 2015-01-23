require 'spec_helper'

describe Ingenia::Tag do
  let(:empty_api_response) { { 'status' => 'okay', 'data' => {} } }


  describe '#create' do
    let(:name) { 'this is a test tag' }
    let(:path) { '/tags' }
    let(:request) { { json: "{\"name\":\"#{name}\",\"tag_set_id\":1}", api_key: "1234" } }

    specify do
      expect(Ingenia::Api::Remote).to receive(:post).with(path, request) { empty_api_response }
      described_class.create(name: name, tag_set_id: 1)
    end
  end


  describe '#update' do
    let(:name) { 'this is an updated test tag' }
    let(:path) { '/tags/1' }
    let(:request) { { json: "{\"name\":\"#{name}\",\"tag_set_id\":1}", api_key: "1234" } }

    specify do
      expect(Ingenia::Api::Remote).to receive(:put).with(path, request) { empty_api_response }
      described_class.update(1, name: name, tag_set_id: 1)
    end
   end

  describe '#merge' do
    let(:tag_ids) { [1, 2, 3] }
    let(:path) { '/tags/1/merge' }
    let(:request) { { json: "{\"tag_ids\":[1,2,3]}", api_key: "1234" } }

    specify do
      expect(Ingenia::Api::Remote).to receive(:post).with(path, request) { empty_api_response }
      described_class.merge(1, tag_ids: tag_ids)
    end
  end

  describe '#get' do
    let(:path) { '/tags/1' }
    let(:request) { { api_key: "1234" } }

    specify do
      expect(Ingenia::Api::Remote).to receive(:get).with(path, request) { empty_api_response }
      described_class.get(1)
    end
  end

  describe '#all' do
    let(:path) { '/tags' }
    let(:request) { { :offset => 0, :limit => 50, :api_key => "1234" } }

    it 'calls get' do
      expect(Ingenia::Api::Remote).to receive(:get).with(path, request) { empty_api_response }
      described_class.all(offset: 0, limit: 50)
    end
  end

  describe '#delete' do
    let(:path) { '/tags/1' }
    let(:request) { { :params => { :api_key => "1234" } } }

    it 'calls delete' do
      expect(Ingenia::Api::Remote).to receive(:delete).with(path, request) { empty_api_response }
      described_class.destroy(1)
    end
  end
end


