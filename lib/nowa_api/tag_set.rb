class Nowa::TagSet
  include Nowa::Api

  PATH = '/tag_sets'

  # Get a single tag_set by id
  def self.get id
    Nowa::Api.verify_response do
      Remote.get "#{PATH}/#{id}", :api_key => Nowa::Api.api_key
    end
  end

  # Create a new tag_set
  def self.create name
    request_json = { :name => name }

    Nowa::Api.verify_response do
      Remote.post(PATH, :json => request_json.to_json, :api_key => Nowa::Api.api_key )
    end
  end

  # Update an existing tag_set
  def self.update id, name
    request_json = { :name => name }
    
    Nowa::Api.verify_response do
      Remote.put("#{PATH}/#{id}", :json =>  request_json.to_json, :api_key => Nowa::Api.api_key )
    end
  end

  # Index your tag_sets
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