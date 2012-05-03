
module Nowa
module Api
  
  class RemoteSession

    def self.get_json(path)

      url = URI.parse(Nowa::Api.endpoint + path)

      response = Net::HTTP.get_response(url) 

      JSON.parse(response.body)

    #rescue \
#      Timeout::Error, 
#      Errno::EINVAL, 
#      Errno::ECONNRESET, 
#      EOFError,
#      Net::HTTPBadResponse, 
#      Net::HTTPHeaderSyntaxError, 
#      Net::ProtocolError,
#      JSON::ParserError => e

      #nil
    end


  end

end
end

