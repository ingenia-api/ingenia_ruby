
module Nowa
module Api
  
  class KnowledgeItem

    attr_reader \
      :title, 
      :status, 
      :id,
      :tags,
      :words,
      :url,
      :created

    def initialize(api_key, id = nil)
      @api_key     = api_key
      @id          = id
      @create_from = {}
      @title       = '(untitled)'
      @tags        = ''
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

      if new_record?
        RemoteSession.post_json(
          "/knowledge_items.json", 
          :api_key => @api_key, 
          :knowledge_item => to_hash 
        )

      else
        RemoteSession.put_json(
          "/knowledge_items/#{@id}.json", 
          :api_key => @api_key, 
          :knowledge_item => to_hash 
        ) 
      end

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
      raise "Already have a source (#{source})" unless @create_from.empty?
      @dirty = true
      @create_from = { :url => url }
    end

    def text=(text)
      raise "Cannot set text on an existing Knowledge Item" unless new_record?
      raise "Already have a source (#{source})" unless @create_from.empty?
      @dirty = true
      @create_from = { :text => text }
    end

    def upload_from=(path)
      raise "Cannot upload content to an existing Knowledge Item" unless new_record?
      raise "Already have a source (#{source})" unless @create_from.empty?
      @dirty = true
      @create_from = { :upload => path }
    end

    def to_hash
      hash = {}
      hash[:title] = @title
      hash[:tags] = @tags unless @tags.empty?

      if @create_from.has_key? :text
        hash[:text] = @create_from[:text] 

      elsif @create_from.has_key? :url
        hash[:url] = @create_from[:url]

      elsif @create_from.has_key? :upload
        hash[:upload] = @create_from[:upload]
      end

      hash
    end

    def source
      return @source if @source
      @create_from.keys.join.to_s 
    end
      
    def json_url
      "/knowledge_items/#{@id}.json"
    end
      



  end

end
end

