#!/usr/bin/ruby
require 'watir'
require 'watir-scroll'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir __dir__
loader.setup

# @brief  main
#
# @param  argv: Array
# @param  argc: Integer
#
# @return ?
# @since  0.1
#
# @todo   let the developer provide the list of tests that are ran
def main argv = [], argc

  if argv.include? '--server'
    Server.run!
    return false
  end
  
  Thread.new {
    Server.run!
  }

  Thread.new {
    Fx::pipe({ headless: ARGV.first != 'visible',
               options: {
                 args: [ 'start-fullscreen' ]
               }
             },
             -> (opts) {
               Watir::Browser.new :chrome,
                                  opts
             },
             -> (b) {                      

               Watir.default_timeout = 10
               b.window.resize_to 1366, 768
    
               [
                 Tests::ProjectNameHere::Basic
               ].each do |c|
                 c.methods(false).sort.each do |m|
                   if "assert" != m[0..5]
                     next
                   end
                   Fx::perform c.method(m), b, "#{c}::#{m}"
                 end
               end
               
               Server.stop!
             })
  }.join
  
end

main ARGV, ARGV.count
