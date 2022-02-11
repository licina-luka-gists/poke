require 'json'
require 'httparty'

class Client

  # @brief  an HTTP client shortcut
  #
  # @param  ?
  # @param  ?
  # @param  ?
  # @param  ?
  #
  # @return mixed
  # @since  ?
  def hit verb,
          uri,
          headers = { 'Accept' => 'text/html' },
          payload = {}

    begin
      return Fx::as((HTTParty.method(verb).call uri,
                                                { :headers => headers }),
                    -> (t) {
                      if headers['Accept'] == 'text/html'
                        return t.body
                      end
                      
                      return JSON.parse t.body
                    })
    rescue => e
      return e.message
    end
  end
  
end
