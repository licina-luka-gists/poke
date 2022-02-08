require 'sinatra/base'
require 'haml'

class Server < Sinatra::Base

  enable :logging
  
  get '/sinatra' do
    return 'sinatra running'
  end

end
