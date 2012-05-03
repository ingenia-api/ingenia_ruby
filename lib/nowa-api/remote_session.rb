
module Nowa
module Api
  
  # i hate ruby http. i mean, wtf guys? sort it out already
  class RemoteSession

    def self.get_json(path, opts = {})

      url = URI.parse(Nowa::Api.endpoint + path)

      req = Net::HTTP::Get.new(url.path)

      req.basic_auth opts[:api_key], '' unless opts[:api_key].nil?

      http = Net::HTTP.new(url.host, url.port).start

      if http.started?

        response = http.request(req)

        returns = JSON.parse(response.body) if response.is_a? Net::HTTPOK

        http.finish
      end

      returns


    rescue \
      JSON::ParserError => e
#      Timeout::Error, 
#      Errno::EINVAL, 
#      Errno::ECONNRESET, 
#      EOFError,
#      Net::HTTPBadResponse, 
#      Net::HTTPHeaderSyntaxError, 
#      Net::ProtocolError,

      nil
    end


  end

end
end

