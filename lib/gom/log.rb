require 'gom/logger'

module Gom
  # GOM default Logger instance
  Log = Gom::Logger.new

  # TODO: runtime configuration might move to config/initializers/...
  Log.level = ::Logger::DEBUG
end

__END__

  Log = ::Logger.new case RAILS_ENV
    when "test" 
      STDOUT
    else 
      "#{RAILS_ROOT}/log/gom-#{RAILS_ENV}.log"
  end

  class << Log
    # this is to de-patch the rails formatting patch..
    def format_message(severity, timestamp, progname, msg)
      "#{timestamp.to_formatted_s(:db)} #{severity.first} #{msg}\n" 
    end 

    # experimental convenience function:
    #
    #   Log.ex e
    #
    # does actually do: 
    #   Log.error e
    #   Log.debug "#{e.backtrace.join "\n\t"}"
    #
    # and:
    #   Log.ex e, "some message here"
    #
    # stands for:
    #   Log.error "some message here"
    #   Log.debug "#{e.backtrace.join "\n\t"}"
    #
    def ex e, msg = nil, level = :error
      send level, (msg || e)
      debug "#{e} -- error was: #{msg}\n\t#{e.backtrace.join "\n\t"}"
    end
  end

  # TODO: runtime configuration might move to config/initializers/...
  Log.level = ::Logger::DEBUG
end
