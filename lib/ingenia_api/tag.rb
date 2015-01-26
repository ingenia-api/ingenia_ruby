class Ingenia::Tag
  include Ingenia::Api

  PATH             = '/tags'

  # These are known request params, all other params will go inside the json object
  TAG_KNOWN_PARAMS = %i{ full_text offset limit tag_ids }

  # Get a single tag by id
  def self.get id, params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.get "#{PATH}/#{id}", @params
    end
  end

  # Create a new tag
  def self.create params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.post(PATH, @params)
    end
  end

  # Update an existing tag
  def self.update id, params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.put("#{PATH}/#{id}", @params)
    end
  end

  # Update an existing tag
  def self.merge id, params = {}
    # dirty hack
    params[:tag_ids] = params[:tag_ids].to_json
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.post("#{PATH}/#{id}/merge", @params)
    end
  end

  # Index your tags
  def self.all params = {}
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.get(PATH, @params)
    end
  end

  def self.destroy id
    Ingenia::Api.verify_response do
      Remote.delete("#{PATH}/#{id}", :params => { :api_key => Ingenia::Api.api_key })
    end
  end

  private
  def self.initialize_params(params = {})
    # break params down into for json object and for request
    request_params = params.select { |k, v| TAG_KNOWN_PARAMS.include?(k) }
    json_params    = params.select { |k, v| not TAG_KNOWN_PARAMS.include?(k) }

    @params = { :api_key => Ingenia::Api.api_key }
    @params.merge!({ :json => json_params.to_json }) unless json_params.empty?
    @params.merge! request_params
  end
end