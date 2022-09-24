require 'sinatra/base'
require 'haml'

class Routes < Sinatra::Base

  set :views, Proc.new{
    File.join root, '/../', 'pokes', 'views'
  }
  
  get 'custom/routes' do
    return 'hello world'
  end
  
end
