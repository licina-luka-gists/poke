require 'sinatra/base'
require 'haml'

class Server < Sinatra::Base

  enable :logging
  
  get '/sinatra' do
    return 'sinatra running'
  end

  get '/proxied' do
    return haml :proxied
  end
  
  get '/pseudo' do
    return Client.new.get 'http://localhost:4567/proxied'
  end

end
