class Server < Routes

  enable :logging
  disable :show_exceptions
  
  get '/sinatra' do
    return 'sinatra running'
  end

  get '/proxied' do
    return haml :proxied
  end
  
  get '/pseudo' do
    return Client.new.hit 'get',
                          'http://localhost:4567/proxied',
                          { 'Accept' => 'text/html' }
  end

  get '/api/json/masked' do
    puts request.env['HTTP_AUTHORIZATION']
    return '{"result":"masked"}'
  end
  
  get '/page/masked' do
    Fx::pipe({ 'Accept'        => 'application/json',
               'Authorization' => "Bearer #{request.cookies['token']}" },
             -> (t) {
               Client.new.hit 'get',
                              'http://localhost:4567/api/json/masked',
                              t
             },
             -> (t) {
               haml :page,
                    {
                      locals: {
                        data: t
                      }
                    }
             })
  end

end
