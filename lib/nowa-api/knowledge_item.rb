
module Nowa
module Api
  
  class KnowledgeItem

    def self.fetch(id, key)

      args = RemoteSession.get_json( "/knowledge_items/#{id}.json", :api_key => key)
      return nil if args.nil?

      new(key).tap do |ki|
        ki.set args
      end
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

    def initialize(api_key)
      @api_key = api_key
      @create_from = {}
      @created = Time.now
    end

    # nodoc
    def set(from={})
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
      return unless dirty?

      RemoteSession.put_json(
        "/knowledge_items/#{@id}.json", 
        :api_key => @api_key, 
        :knowledge_item => to_hash 
      ) 
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

    def url=(url)
      raise "Cannot set URL on an existing Knowledge Item" unless new_record?
      raise "Already have a source (#{@create_from.keys.join})" unless @create_from.empty?
      @dirty = true
      @create_from = { :url => url }
    end

    def text=(text)
      raise "Cannot set text on an existing Knowledge Item" unless new_record?
      raise "Already have a source (#{@create_from.keys.join})" unless @create_from.empty?
      @dirty = true
      @create_from = { :text => text }
    end

    def upload_from=(path)
      raise "Cannot upload content to an existing Knowledge Item" unless new_record?
      raise "Already have a source (#{@create_from.keys.join})" unless @create_from.empty?
      @dirty = true
      @create_from = { :upload_from => path }
    end

    def to_hash
      {
        :title => @title,
        :tags => @tags
      }
    end
      



  end

end
end

