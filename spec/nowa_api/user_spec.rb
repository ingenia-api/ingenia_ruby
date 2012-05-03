require 'spec_helper'

describe Nowa::Api::User do
  
  describe 'login' do
    it 'takes a user key' do
      user = Nowa::Api::User.new('1234abcd')
      user.api_key.should == '1234abcd'
    end
  end

  describe '#knowledge_items' do
    it 'returns empty array if nothing found' do

      stub_json_get '/knowledge_items', 'empty_array.json', :auth_token => '1234abcd'

      user = Nowa::Api::User.new('1234abcd')

      user.knowledge_items.should == []
    end

    it 'returns some KIs' do
      stub_json_get '/knowledge_items', 'five_knowledge_items_index.json', :auth_token => '1234abcd'

      user = Nowa::Api::User.new('1234abcd')

      5.times do
        user.knowledge_items.shift.class.should == Nowa::Api::KnowledgeItem
      end
    end
  end

end
