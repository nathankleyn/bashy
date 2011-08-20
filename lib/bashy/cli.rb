require 'optparse'

module Bashy
  class Cli
    
    attr_accessor :arguments, :options
  
    def initialize(options = {})
      @options = options
    end
    
    def self.start(*args)
      cli = self.new(*args)
      cli.parse_arguments!
      cli.parse_commands!
      cli
    end
    
    def arguments_base
      @options[:arguments_base] || ARGV
    end
    
    def arguments_base=(arguments_base)
      @options[:arguments_base] = arguments_base
    end
    
    def parse_arguments!
      parsed_arguments = {}
      
      OptionParser.new do |parser|
        parser.banner = "Usage: bashy [options]"

        parser.on("-v", "--version", "Print version information") do
          parsed_arguments[:version] = true
        end
        
        parser.on("--config-dir DIR", "Specify the directory to locate the configuration files") do |config_dir|
          parsed_arguments[:config_dir] = config_dir
        end
        
      end.parse!(arguments_base)
      
      parsed_arguments
    end
    
    def parse_commands!(arguments = [])
      command_proxy = create_command_proxy
      if arguments_base.length > 0
        if command_proxy.respond_to?(arguments_base[0])
          command_proxy.__send__(arguments_base[0], *arguments_base[1..-1])
        else
          raise Bashy::CommandNotFoundError
        end
      else
        raise Bashy::CommandNotPassedError
      end
    end
    
    def create_command_proxy
      Bashy::CommandProxy.new(options)
    end
    
  end # class
end # module
