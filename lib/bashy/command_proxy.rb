Dir["./lib/bashy/commands/**/*.rb"].each { |f| p f; require f }

module Bashy
  class CommandProxy
    
    def initialize(options)
      @options = options
    end
    
    Bashy::Command.constants.each do |command|
      define_method command.downcase do |*arguments|
        Bashy::Command.const_get(command).new(*arguments)
      end
    end
    
  end # class
end # module
