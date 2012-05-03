
module Nowa
module Api
  
  class KnowledgeItem

    def self.fetch(id, key)

      args = RemoteSession.get_json( "/knowledge_items/#{id}.json", :api_key => key)
      return nil if args.nil?

      args[:api_key] = key

      self.new(args)
    end

    def initialize(from={})
    end

  end

end
end

