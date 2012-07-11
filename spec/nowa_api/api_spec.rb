require 'spec_helper' 

describe Nowa::Api do

  describe '::classify' do
    it 'calls remote url properly' do
      Nowa::Api::Remote.should_receive( :post ).with( '1234', '/classify', :text => 'some text' )

      Nowa::Api.classify '1234', 'some text'
    end
  end

  describe '::train' do
    it 'calls remote url properly with array tags' do
      Nowa::Api::Remote.should_receive( :post ).with( '1234', '/train', :text => 'some text', :tags => %w{ some tags }.to_json )

      Nowa::Api.train '1234', 'some text', %w{ some tags }
    end

    it 'calls remote url properly with nested tags' do

      tags = {
        :tag_set_1 => %w{ tag1 tag2 tag3 },
        :tag_set_2 => %w{ tag4 tag5 tag6 }
      }

      test_payload = {
        :text => 'some text',
        :tag_sets => tags.to_json
      }

      Nowa::Api::Remote.should_receive( :post ).with( '1234', '/train', test_payload )

      Nowa::Api.train '1234', 'some text', tags
    end
  end
  
end


