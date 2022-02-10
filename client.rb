require 'json'
require 'httparty'

class Client

  def get uri, headers = { 'Accept' => 'text/html' }
    return Fx::as((HTTParty.get uri,
                                { :headers => headers }),
                  -> (t) {
                    if headers['Accept'] == 'text/html'
                      return t.body
                    end

                    return JSON.parse t.body
                  })
  end

  def post uri, req
    return false
  end

end
