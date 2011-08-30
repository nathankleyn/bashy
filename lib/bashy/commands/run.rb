require './lib/bashy/commands/base'

module Bashy
  module Command
    class Run < Base
      
      def initialize(name, *arguments)
        super
        
        config = Bashy::Config.load
        if config["commands"].has_key?(name)
          exec(File.join(Bashy::Config::CONFIG_DIR_PATH, "commands", name, config["commands"][name]["file"]), *arguments)
        else
          
        end
      end
      
    end # class
  end # module
end # module
