require 'watir'
require 'watir-scroll'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir __dir__
loader.setup

def main argv = [], argc
  
  Thread.new {
    Server.run!
  }

  Thread.new {
    b = Watir::Browser.new :chrome,
                           { headless: ARGV.first != 'visible',
                             options: {
                               args: [ 'start-fullscreen' ]
                             }
                           }

    b.timeout = 10
    b.window.resize_to 1366, 768
    
    [ Tests::ProjectNameHere::Basic ].each do |c|
      c.methods(false).sort.each do |m|
        if "assert" != m[0..5]
          next
        end
        Fx::perform c.method(m), b, "#{c}::#{m}"
      end
    end
    Server.stop!
  }.join
  
end

main ARGV, ARGV.count
