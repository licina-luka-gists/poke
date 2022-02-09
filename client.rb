require 'net/http'
require 'uri'

class Client

  def get uri
    return Net::HTTP.get URI(uri)
  end

  def post uri, payload
    return false
  end

end
