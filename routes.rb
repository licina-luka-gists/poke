require 'sinatra/base'
require 'haml'

class Routes < Sinatra::Base

  get 'custom/routes' do
    return 'hello world'
  end
  
end
