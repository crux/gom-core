require 'logger'

module Gom

  class Logger < ::Logger

    #Gom::Log.level = Gom::Attribute.value("/gom/log:level", ::Logger::INFO)

    Levels = {
      "debug" => ::Logger::DEBUG,
      "info"  => ::Logger::INFO,
      "warn"  => ::Logger::WARN,
      "error" => ::Logger::ERROR,
      "fatal" => ::Logger::FATAL,
    }

    # output defaults to STDOUT for rails test and non-rails apps, to a
    # logfile otherwise
    #
    DEFAULT_OUT = begin
                    if ! (Object.const_defined? 'Rails')
                      STDOUT
                    else
                      if 'test' === ::Rails.env
                        STDOUT
                      else 
                        "#{::Rails.root.to_s}/log/gom-#{::Rails.env}.log"
                      end
                    end
                  end

    def initialize out = DEFAULT_OUT
      super out
      self.level = ::Logger::DEBUG
    end

    # this is to de-patch the rails formatting patch..
    def format_message(severity, timestamp, progname, msg)
      "#{timestamp.strftime '%Y-%m-%d %H:%M:%S'} #{severity.chars.first} #{msg}\n"
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
      send level, "#{e}: #{(msg || e)}"
      debug "#{e} -- callstack: #{msg}\n\t#{e.backtrace.join "\n\t"}"
    end
  end
end
