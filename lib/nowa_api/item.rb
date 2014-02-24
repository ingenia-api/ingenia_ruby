class Nowa::Item
  include Nowa::Api

  PATH = '/items'

  # These are known request params, all other params will go inside the json object
  ITEM_KNOWN_PARAMS = %i{ classify full_text file update_existing offset limit }

  # Get a single item by id
  def self.get( id, params = {} )
    initialize_params params

    Nowa::Api.verify_response do
      Remote.get( "#{PATH}/#{id}", @params )
    end
  end

  ##
  # Create a new item
  # 
  #
  def self.create( params = {} )
    initialize_params params    

    Nowa::Api.verify_response do
      Remote.post( PATH, @params )
    end
  end

  ##
  # Find or create a new item by text
  # 
  #
  def self.find_or_create_by_text( params = {} )
    initialize_params params    

    Nowa::Api.verify_response do
      Remote.post( PATH, @params )
    end
  end

  #
  # Update an existing item
  #
  def self.update( id, params = {} )
    initialize_params params

    Nowa::Api.verify_response do
      Remote.put("#{PATH}/#{id}", @params )
    end
  end

  #
  # Index your items
  #
  def self.all params = {}
    initialize_params params
    
    Nowa::Api.verify_response do
      Remote.get( PATH, @params )
    end
  end

  #
  # Destroy an item
  #
  def self.destroy id
    Nowa::Api.verify_response do
      Remote.delete("#{PATH}/#{id}", :params => { :api_key => Nowa::Api.api_key} )
    end
  end


  private
    def self.initialize_params( params = {} )
      # break params down into for json object and for request
      request_params = params.select{ |k,v| ITEM_KNOWN_PARAMS.include?(k) }

      json_params = params.select{ |k,v| not ITEM_KNOWN_PARAMS.include?(k) }

      @params = { :api_key => Nowa::Api.api_key }
      @params.merge!( { :json => json_params.to_json } ) unless json_params.empty? 
      @params.merge! request_params
    end
end