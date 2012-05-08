
module Nowa
module Api
  
  class KnowledgeItem

    attr_reader \
      :title, 
      :status, 
      :id,
      :tags,
      :words,
      :source,
      :url,
      :created

    def initialize(api_key, id = nil)
      @api_key = api_key
      @create_from = {}
      @id = id
    end

    def fetch
      args = RemoteSession.get_json( json_url , :api_key => @api_key)
      return nil if args.nil?

      #@id      = args['id']
      @title   = args['title']
      @status  = args['status']
      @tags    = args['tags']
      @words   = args['words']
      @source  = args['source']
      @url     = args['url']
      @created = Time.at(args['created'] || 0)

      self
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

    def errors
      []
    end

    def json_url
      "/knowledge_items/#{@id}.json"
    end
      



  end

end
end

