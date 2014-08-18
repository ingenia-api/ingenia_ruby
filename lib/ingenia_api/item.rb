class Ingenia::Item
  include Ingenia::Api

  PATH = '/items'

  # Get a single item by id
  def self.get( id, params = {} )
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.get( "#{PATH}/#{id}", @params )
    end
  end

  ##
  # Create a new item
  #
  #
  def self.create( params = {} )
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.post( PATH, @params )
    end
  end

  ##
  # Find or create a new item by text
  #
  #
  def self.find_or_create_by_text( params = {} )
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.post( PATH, @params )
    end
  end

  #
  # Update an existing item
  #
  def self.update( id, params = {} )
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.put("#{PATH}/#{id}", @params )
    end
  end

  #
  # Index your items
  #
  def self.all params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.get( PATH, @params )
    end
  end

  #
  # Destroy an item
  #
  def self.destroy id
    Ingenia::Api.verify_response do
      Remote.delete("#{PATH}/#{id}", :params => { :api_key => Ingenia::Api.api_key} )
    end
  end


  private
    def self.initialize_params( params = {} )
      @params = params.clone

      @params[:json] = @params[:json].to_json if @params[:json]
      @params.merge!( { :api_key => Ingenia::Api.api_key } )
    end
end
