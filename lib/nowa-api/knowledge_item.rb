
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
      :created,
      :save_errors

    def initialize(api_key, id = nil)
      @api_key     = api_key
      @id          = id
      @create_from = {}
      @title       = '(untitled)'
      @tags        = ''
    end

    def fetch
      args = RemoteSession.get_json( json_path, @api_key)
      return nil if args.nil? || args[:status] == 'error'

      values = args['knowledge_item']

      #@id      = values['id']
      @title   = values['title']
      @status  = values['status']
      @tags    = values['tags']
      @words   = values['words']
      @source  = values['source']
      @url     = values['url']
      @created = Time.at(values['created'] || 0)

      self
    end

    def new_record?
      @id.nil?
    end

    def save
      return unless dirty?

      res = {}

      if new_record?
        raise "You need a source!" if @create_from.empty?

        res = RemoteSession.post_json json_path, @api_key, :tags_by_tag_set => tags_params, :knowledge_item => ki_params
      else
        res = RemoteSession.put_json  json_path, @api_key, :tags_by_tag_set => tags_params, :knowledge_item => ki_params
      end

      if res
        if res['status'] == 'okay'
          @dirty = false
          return true
        else
          @save_errors = res['errors']
          return false
        end
      else
        @save_errors = [ 'server error' ]
        return false
      end
    end

    def dirty?
      @dirty
    end

    def title=(text)
      @dirty = true
      @title = text
    end

    def tags=(tags)
      raise "tags needs to be a hash" unless tags.is_a? Hash
      @dirty = true
      @tags = tags
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

    def source
      return @source if @source
      @create_from.keys.join.to_s 
    end


    private

    def ki_params
      hash = {}
      hash[:title] = @title

      if @create_from.has_key? :text
        hash[:original_text] = @create_from[:text] 

      elsif @create_from.has_key? :url
        hash[:url] = @create_from[:url]

      elsif @create_from.has_key? :upload
        hash[:original_file] = File.new(@create_from[:upload])
      end

      hash
    end

    def tags_params
      @tags.to_json
    end

    def json_path
      new_record? ? "/knowledge_items.json" : "/knowledge_items/#{@id}.json"
    end
  end

end
end

