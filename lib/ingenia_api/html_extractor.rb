class Ingenia::HtmlExtractor
  class MissingUrl < StandardError; end

  include Ingenia::Api

  PATH = '/html_extractor'

  # Fetch the url html
  def self.fetch( params = {} )
    raise(MissingUrl) unless params.has_key?(:url)
    initialize_params params

    Ingenia::Api.verify_response do
      Remote.get( "#{PATH}/fetch", @params )
    end
  end


  private
    def self.initialize_params( params = {} )
      @params = params.clone
      @params.merge!( { :api_key => Ingenia::Api.api_key } )
    end
end
