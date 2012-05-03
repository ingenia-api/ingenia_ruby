require 'spec_helper' 

describe Nowa::Api::KnowledgeItem do

  describe '::fetch' do

    it 'makes an object from remote data' do
      
        stub_json_get "/knowledge_items/123.json", 'knowledge_item.json', :auth_token => '1234abcd'

        ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')

        ki.new_record?.should_not be_true
        ki.title.should_not       be_empty
        ki.status.should_not      be_empty
        ki.tags.should_not        be_empty
        ki.words.should_not       be_empty
        ki.source.should_not      be_empty
    end
    
  end
  
end

