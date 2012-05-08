require 'spec_helper' 

describe Nowa::Api::KnowledgeItem do

  describe '::fetch' do

    it 'makes an object from remote data' do
      
        stub_json_get "/knowledge_items/123.json", 'knowledge_item.json', :auth_token => '1234abcd'

        ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')

        ki.new_record?.should_not be_true

        ki.title.should   == "A Knowledge Item"
        ki.status.should  == "okay"
        ki.tags.should    == "some tags about this item"
        ki.words.should   == "words in this knowledge item they are unique"
        ki.source.should  == "upload"
        ki.created.should == Time.at(1336468441)
    end
  end

  describe '.save' do

    it 'doesn\'t save things that haven\'t changed'
  end
  
end

