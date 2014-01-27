class Nowa::Bundle
  include Nowa::Api

  PATH = '/bundles'

  # These are known request params, all other params will go inside the json object
  BUNDLE_KNOWN_PARAMS = %i{ full_text offset limit }

  # Get a single bundle by id
  def self.get id, params = {}
    initialize_params params

    Nowa::Api.verify_response do
      Remote.get "#{PATH}/#{id}", @params
    end
  end

  # Create a new bundle
  def self.create params = {}
    initialize_params params

    Nowa::Api.verify_response do
      Remote.post(PATH, @params )
    end
  end

  # Update an existing bundle
  def self.update id, params = {}
    initialize_params params

    Nowa::Api.verify_response do
      Remote.put("#{PATH}/#{id}", @params )
    end
  end


  # Index your bundles
  def self.all params = {}
    initialize_params params

    Nowa::Api.verify_response do
      Remote.get(PATH, @params )
    end
  end

  def self.destroy id
    Nowa::Api.verify_response do
      Remote.delete("#{PATH}/#{id}", :params => { :api_key => Nowa::Api.api_key} )
    end
  end

  private
    def self.initialize_params( params = {} )
      # break params down into for json object and for request
      request_params = params.select{ |k,v| BUNDLE_KNOWN_PARAMS.include?(k) }
      json_params = params.select{ |k,v| not BUNDLE_KNOWN_PARAMS.include?(k) }

      @params = { :api_key => Nowa::Api.api_key }
      @params.merge!( { :json => json_params.to_json } ) unless json_params.empty? 
      @params.merge! request_params
    end
end