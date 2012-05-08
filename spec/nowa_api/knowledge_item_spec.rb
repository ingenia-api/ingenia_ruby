require 'spec_helper' 

describe Nowa::Api::KnowledgeItem do

  describe '::fetch' do

    it 'makes an object from remote data' do
      
        stub_json_get "/knowledge_items/123.json", 'knowledge_item.json', :auth_token => '1234abcd'

        ki = Nowa::Api::KnowledgeItem.new('1234abcd', 123).fetch

        ki.new_record?.should_not be_true

        ki.title.should   == "A Knowledge Item"
        ki.status.should  == "okay"
        ki.tags.should    == "some tags about this item"
        ki.words.should   == "words in this knowledge item they are unique"
        ki.source.should  == "upload"
        ki.created.should == Time.at(1336468441)
    end
  end
  
  describe '.initialize' do

    it 'sets empty source' 
    it 'takes an api_key which is used in save'
  end

  describe 'existing KI' do

    before :each do
      stub_json_get "/knowledge_items/123.json", 'knowledge_item.json', :auth_token => '1234abcd'
    end

    describe '.dirty?' do
      before :each do
        @ki = Nowa::Api::KnowledgeItem.new('1234abcd', 123).fetch
      end

      it 'is clear by default' do
        @ki.dirty?.should be_false
      end

      it 'gets set when value changes' do
        @ki.title = 'A new title'
        @ki.dirty?.should be_true
      end

      it 'gets cleared when save occours' do
        @ki.title = 'A new title'
        @ki.save
        @ki.dirty?.should be_false
      end
    end

    describe '.save' do

      it 'doesn\'t save things that haven\'t changed' do
        Nowa::Api::RemoteSession.should_not_receive( :put_json )
        ki = Nowa::Api::KnowledgeItem.new('1234abcd', 123).fetch
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

        ki = Nowa::Api::KnowledgeItem.new('1234abcd', 123).fetch
        ki.title = 'The new title'
        ki.tags = 'Some different tags'
        ki.save
      end

    end

    describe 'unsettable field' do

      describe 'url=' do

        it 'complains you are trying to set it' do

          error_message =  "Cannot set URL on an existing Knowledge Item" 

          ki = Nowa::Api::KnowledgeItem.new('1234abcd', 123).fetch

          lambda { ki.url = 'http://nogood.com' }.should raise_error( RuntimeError, error_message )
        end

#        it 'can only be have one source' do
#
#          error_message =  "Already have a source (url)" 
#
#          ki = Nowa::Api::KnowledgeItem.new
#
#          lambda { 
#            ki.url = 'http://nogood.com'
#            ki.text = 'Some text'
#          }.should raise_error( RuntimeError, error_message )
#        end

      end
    end 

    describe '.errors' do
      it 'is empty by default for exisiting KIs' do
        ki = Nowa::Api::KnowledgeItem.new('1234abcd', 123).fetch
        ki.errors.should be_empty
      end
    end

  end # existing KI

  describe 'new KI' do
    
    before :each do
      @ki = Nowa::Api::KnowledgeItem.new('1234abcd')
    end

    # this is also tested above
    describe '.new_record?' do
      it 'is true' do
        @ki.new_record?.should be_true
      end
    end

    # this is also tested above
    describe '.dirty?' do
      it 'is false by default' do
        @ki.dirty?.should_not be_true
      end
    end

    describe '.errors' do
      it 'is empty by default' do
        @ki.errors.should be_empty
      end
    end

    describe '.save' do
      
    end
  end



  
end

