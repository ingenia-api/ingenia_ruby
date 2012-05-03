
module Nowa
module Api
  
  class User

    attr_reader :api_key

    def initialize(key)
      @api_key = key
    end

    def knowledge_items
      
      kis = RemoteSession.get_json('/knowledge_items', :api_key => @api_key)

      return nil if kis.nil?

      @knowledge_items = []
      kis.each do |ki_id|
        @knowledge_items << KnowledgeItem.new( :from_id => ki_id )
      end

      @knowledge_items

    end

#    def email
#      attributes 'email'
#    end
#
#    private
#    
#    def attributes
#      @attributes ||= RemoteSession.get_json("
#    end

  end

end
end
