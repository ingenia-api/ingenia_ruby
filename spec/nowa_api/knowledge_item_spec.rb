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
  

  describe 'KI creation' do
    
    before :each do
      @ki = Nowa::Api::KnowledgeItem.new('1234abcd')
    end

    describe '.title' do
      it 'defaults to untitled' do
        @ki.title.should == '(untitled)'
      end
    end

    describe 'posting a new kitem' do
      describe 'with title and no text' do
        it "raises an exception"
      end
      


    end


   
  end


  describe 'existing KI' do

    before :each do
      stub_json_get "/knowledge_items/123.json", 'knowledge_item.json', :auth_token => '1234abcd'
      stub_json_put "/knowledge_items/123.json", 'success.json', :auth_token => '1234abcd'
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

        tags_by_tagset = {
          'ts1' => %w{ t1 t2 t3 },
          'ts2' => %w{ t4 t5 t6 }
        }

        post_args = {
          :tags_by_tag_set => tags_by_tagset.to_json,
          :knowledge_item => {
            :title => 'The new title'
          }
        }

        Nowa::Api::RemoteSession.
          should_receive( :post_json ).
          with( "/api/knowledge_items.json", '1234abcd', post_args ).
          once.
          and_return( :status => 'okay' )

        ki = Nowa::Api::KnowledgeItem.new('1234abcd')
        ki.title = 'The new title'
        ki.tags  = tags_by_tagset
        ki.url   = 'http://example.com'
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
      end
    end 

    describe '.source' do
      it 'is set from remote params' do
        ki = Nowa::Api::KnowledgeItem.new('1234abcd', 123)
        ki.source.should == ''
        ki = ki.fetch
        ki.source.should == 'upload'
      end
    end
    
  end # existing KI


  
end

