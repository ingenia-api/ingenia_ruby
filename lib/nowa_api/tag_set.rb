class Ingenia::TagSet
  include Ingenia::Api

  PATH = '/tag_sets'
  TAG_SET_KNOWN_PARAMS = %i{ offset limit } 

  # Get a single tag_set by id
  def self.get id
    Ingenia::Api.verify_response do
      Remote.get "#{PATH}/#{id}", :api_key => Ingenia::Api.api_key
    end
  end

  # Create a new tag_set
  def self.create params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.post(PATH, @params )
    end
  end

  # Update an existing tag_set
  def self.update id, params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.put("#{PATH}/#{id}", @params )
    end
  end

  # Index your tag_sets
  def self.all params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.get(PATH, @params )
    end
  end

  def self.destroy id
    Ingenia::Api.verify_response do
      Remote.delete("#{PATH}/#{id}", :params => { :api_key => Ingenia::Api.api_key} )
    end
  end


  private
    def self.initialize_params( params = {} )
      # break params down into those for json object and those for request
      request_params = params.select{ |k,v| TAG_SET_KNOWN_PARAMS.include?(k) }
      json_params = params.select{ |k,v| not TAG_SET_KNOWN_PARAMS.include?(k) }


      @params = { :api_key => Ingenia::Api.api_key }
      @params.merge!( { :json => json_params.to_json } ) unless json_params.empty? 
      @params.merge! request_params
    end
end