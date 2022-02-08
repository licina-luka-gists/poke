class Fx

  # @return mixed
  def self.pipe *args
    return args.reduce &->(acc, el) {
      el.class == Proc ? el.call(acc) : el
    }
  end

  # @return ?
  def self.as *args
    i = args.shift
    o = nil
    args.each &->(el) {
      o = el.call(i)
    }

    return o
  end

  # @return void
  def self.log message, failed = false
    on  = failed ? "\u001b[31m" : "\u001b[32m"
    off = "\u001b[0m"
    res = !failed ? "success" : "failure"
    puts "#{on}#{res}#{off}: #{message}"
  end

  # @return void
  def self.notice message
    log message, true
  end

  # @brief  performs a test, logs events, catches
  #         failures
  #
  # @param  test: proc
  # @param  b:    Watir::Browser
  # @param  name: String
  #
  # @return void
  # @since  0.12.0
  def self.perform test, b, name
    begin
      if ! test.call b
        raise "false"
      end

      Fx::log name
    rescue => e
      Fx::notice "!#{name}: #{e.message}"
    end
  end

end
