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
  
  describe 'existing KI' do

    before :each do
      stub_json_get "/knowledge_items/123.json", 'knowledge_item.json', :auth_token => '1234abcd'
    end

    describe '.dirty?' do
      it 'is clear by default' do
        ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')
        ki.dirty?.should be_false
      end

      it 'gets set when value changes' do
        ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')
        ki.title = 'A new title'
        ki.dirty?.should be_true
      end

      it 'gets cleared when save occours' do
        ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')
        ki.title = 'A new title'
        ki.save
        ki.dirty?.should be_false
      end
    end

    describe '.save' do

      it 'doesn\'t save things that haven\'t changed' do
        Nowa::Api::RemoteSession.should_not_receive( :put_json )
        ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')
        ki.save
      end

      it 'posts new stuff to the server' do

        post_args = {
          :api_key => '1234abcd',
          :knowledge_item => {
            :title => 'The new title',
            :tags => 'Some different tags'
          }
        }

        Nowa::Api::RemoteSession.should_receive( :put_json ).with( "/knowledge_items/123.json", post_args )

        ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')
        ki.title = 'The new title'
        ki.tags = 'Some different tags'
        ki.save
      end

    end

    describe 'unsettable field' do

      describe 'url=' do

        it 'complains you are trying to set it' do

          error_message =  "Cannot set URL on an existing Knowledge Item" 

          ki = Nowa::Api::KnowledgeItem.fetch(123, '1234abcd')

          lambda { ki.url = 'http://nogood.com' }.should raise_error( RuntimeError, error_message )
        end

        it 'can only be have one source' do

          error_message =  "Already have a source (url)" 

          ki = Nowa::Api::KnowledgeItem.new

          lambda { 
            ki.url = 'http://nogood.com'
            ki.text = 'Some text'
          }.should raise_error( RuntimeError, error_message )
        end

      end

    end

  end


  
end

