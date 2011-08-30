module Bashy
  module Command
    class Base
      
      def initialize(*arguments)
        
      end
      
      def self.log(line)
        Bashy::Logger << line
      end
      
    end # class
    
  end # module
end # module
