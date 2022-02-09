module Tests::ProjectNameHere
  class Basic
    
    # @return bool
    # @since  ?
    def self.assertAppCanLoad b
      Fx::pipe(b,
               -> (t) {
                 t.goto 'http:localhost:4567/sinatra'
                 return t
               },
               -> (t) { return t.body.text.include? 'sinatra running' })
    end

    def self.assertEngineCanProxy b
      Fx::pipe(b,
               -> (t) {
                 t.goto 'http:localhost:4567/pseudo'
                 return t
               },
               -> (t) {
                 return (t.element id: 'result').text.include? 'proxied'
               })
    end
    
    # @return bool
    # @since  ?
    def self._assertUserCanLogin b
      Fx::as(b,
             -> (t) {
               (t.goto 'http:localhost:4567/login')
             },
             -> (t) {
               if 1 > (t.elements text: 'Login').count
                 raise Exception
               end
             },
             -> (t) {
               Fx::pipe(t.inputs.first,
                        -> (t2) { t2.send_keys 'admin@admin.com', :tab })
             },
             -> (t) { (t.send_keys 'password', :enter) },
             -> (t) { t.text.include? 'Home' })
    end
  end
end
