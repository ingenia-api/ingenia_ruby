class Nowa::Tag
  include Nowa::Api

  PATH = '/tags'

  # Get a single tag by id
  def self.get id
    Nowa::Api.verify_response do
      Remote.get "#{PATH}/#{id}", :api_key => Nowa::Api.api_key
    end
  end

  # Create a new tag
  def self.create name, tag_set_id
    request_json = { :name => name, :tag_set_id => tag_set_id }

    Nowa::Api.verify_response do
      Remote.post(PATH, :json => request_json.to_json, :api_key => Nowa::Api.api_key )
    end
  end

  # Update an existing tag
  def self.update id, name, tag_set_id
    request_json = { :name => name, :tag_set_id => tag_set_id }

    Nowa::Api.verify_response do
      Remote.put("#{PATH}/#{id}", :json =>  request_json.to_json, :api_key => Nowa::Api.api_key )
    end
  end

  # Index your tags
  def self.all options = {}
    # Defaults
    offset    = 0
    limit     = 50

    offset    = options[:offset]    if options[:offset]
    limit     = options[:limit]     if options[:limit]
    
    Nowa::Api.verify_response do
      Remote.get(PATH, :offset => offset, :limit => limit, :api_key => Nowa::Api.api_key )
    end
  end
  def self.destroy id
    Nowa::Api.verify_response do
      Remote.delete("#{PATH}/#{id}", :params => { :api_key => Nowa::Api.api_key} )
    end
  end
end