
module Nowa
module Api
  
  class KnowledgeItem

    def self.fetch(id, key)

      args = RemoteSession.get_json( "/knowledge_items/#{id}.json", :api_key => key)
      return nil if args.nil?

      args[:api_key] = key

      self.new(args)
    end

    attr_reader \
      :title, 
      :status, 
      :id,
      :tags,
      :words,
      :source,
      :url,
      :created

    def initialize(from={})

      @id      = from['id']
      @title   = from['title']
      @status  = from['status']
      @tags    = from['tags']
      @words   = from['words']
      @source  = from['source']
      @url     = from['url']
      @created = Time.at(from['created'] || 0)
    end

    def new_record?
      @id.nil?
    end

    def save
      #RemoteSession.put_json( "/knowledge_items/#{@id}.json", :api_key => key, to_hash ) if dirty?
      @dirty = false
    end

    def dirty?
      @dirty
    end

    def title=(text)
      @dirty = true
      @title = text
    end

    def tags=(text)
      @dirty = true
      @tags = text
    end
      



  end

end
end

