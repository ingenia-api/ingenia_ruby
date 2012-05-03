require 'spec_helper'

describe Nowa::Api::User do
  
  describe 'login' do
    
    it 'takes a user key' do
      
      user = Nowa::Api::User.new('1234abcd')

      user.api_key.should == '1234abcd'

    end
  end

end
