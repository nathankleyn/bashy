require 'fileutils'

module Bashy
  class Logger
    
    def self.path
      @@path ||= File.join(Bashy::Config::CONFIG_DIR_PATH, "bashy.log")
    end
    
    def self.<<(line)
      # TODO: Should we use a stored file pointer and clean it up with
      # a finalizer here instead?
      unless line.nil?
        Bashy::Config.create
        File.open(self.path, "a+") do |f|
          f.puts(line)
        end
      end
    end
    
  end # class
end # module
