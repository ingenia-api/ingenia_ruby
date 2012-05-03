
module Nowa
module Api
  
  class User

    attr_reader :api_key

    def initialize(key)
      @api_key = key
    end
  end

end
end
