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
    return Client.new.get 'http://localhost:4567/proxied',
                          { 'Accept' => 'text/html' }
  end

  get '/api/json/masked' do
    return '{"result":"masked"}'
  end
  
  get '/page/masked' do
    return haml :page,
                { locals: {
                    data: ( Client.new.get 'http://localhost:4567/api/json/masked',
                                           { 'Accept'        => 'application/json',
                                             'Authorization' => "Bearer #{request.cookies['token']}" }) } }
  end

end
