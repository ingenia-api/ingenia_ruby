
module Nowa
module Api
  
  class User

    attr_reader :api_key

    def initialize(key)
      @api_key = key
    end

    def knowledge_items
      
      data = RemoteSession.get_json('/knowledge_items.json',  @api_key)

      return nil if data.nil?

      kis = data['knowledge_items']

      @knowledge_items = []
      kis.each do |ki|
        @knowledge_items << KnowledgeItem.new(@api_key, ki['id'] ).fetch
      end

      @knowledge_items
    end

    def find_ki(id)
      KnowledgeItem.new( @api_key, id ).fetch
    end

    def create_ki(opts = {})
      KnowledgeItem.new( @api_key )
    end

#    def tags
#      @tags ||= RemoteSession.get_json('/tags.json', @api_key)['tags']
#    end

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
