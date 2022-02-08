require 'sinatra/base'

class Server < Sinatra::Base

  disable :logging
  
  get '/sinatra' do
    return 'sinatra running'
  end

end
