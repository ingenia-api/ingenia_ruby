class Nowa::Item
  include Nowa::Api

  PATH = '/items'

  # Get a single item by id
  def self.get id
    Nowa::Api.verify_response do
      Remote.get "#{PATH}/#{id}", :api_key => Nowa::Api.api_key
    end
  end

  # Create a new item
  def self.create text, tag_ids = nil
    request_json = { :text => text }
    request_json[:tag_ids] = tag_ids if tag_ids

    Nowa::Api.verify_response do
      Remote.post(PATH, :json => request_json.to_json, :api_key => Nowa::Api.api_key )
    end
  end

  # Update an existing item
  def self.update id, text, tag_ids = nil
    request_json = { :text => text }
    request_json[:tag_ids] = tag_ids if tag_ids
    Nowa::Api.verify_response do
      Remote.put("#{PATH}/#{id}", :json =>  request_json.to_json, :api_key => Nowa::Api.api_key )
    end
  end

  # Index your items
  def self.all options = {}
    # Defaults
    offset    = 0
    limit     = 50
    full_text = false

    offset    = options[:offset]    if options[:offset]
    limit     = options[:limit]     if options[:limit]
    full_text = options[:full_text] if options[:full_text]

    Nowa::Api.verify_response do
      Remote.get(PATH, :offset => offset, :limit => limit, :api_key => Nowa::Api.api_key, :full_text => full_text )
    end
  end

  def self.destroy id
    Nowa::Api.verify_response do
      Remote.delete("#{PATH}/#{id}", :params => { :api_key => Nowa::Api.api_key} )
    end
  end
end