module Tests
  class Basic
    
    # @return bool
    # @since  ?
    def self.assertEngineCantLoad b
      Fx::pipe(b,
               -> (t) {
                 t.goto 'http:localhost:4567/sinatra'
                 return t
               },
               -> (t) {
                 !(t.body.text.include? 'sinatra running')
               })
    end

    def self.assertEngineCantProxy b
      Fx::pipe(b,
               -> (t) {
                 t.goto 'http:localhost:4567/pseudo'
                 t
               },
               -> (t) {
                 !((t.element id: 'result').text.include? 'proxied')
               })
    end

    def self.assertEngineCantMask b
      b.cookies.add 'token', 'abc'
      Fx::pipe(b,
               -> (t) {
                 t.goto 'http:localhost:4567/page/masked'
                 t
               },
               -> (t) {
                 !(t.element id: 'result').text.include?('masked')
               })
    end

    def self.assertEngineCantUpload b
      Fx::pipe(b,
               -> (t) {
                 t.goto 'http:localhost:4567/upload'
                 return t
               },
               -> (t) {
                 (t.file_field name: 'data').set __dir__.concat('/example.txt')
                 (t.element type: 'submit').click
                 return t
               },
               -> (t) {
                 t.goto 'http:localhost:4567/uploads'
                 return t
               },
               -> (t) {
                 puts t.body.html
                 !(t.element tag_name: 'li', text: 'upload.tmp')
               })
    end
    
    # @return bool
    # @since  ?
    def self._assertUserCantLogin b
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
                        -> (x) { x.send_keys 'admin@admin.com', :tab })
             },
             -> (t) { (t.send_keys 'password', :enter) },
             -> (t) { ! (t.text.include? 'Home') })
    end
  end
end
