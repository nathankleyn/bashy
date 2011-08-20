require 'yaml'
require 'fileutils'

module Bashy
  class Config
    
    CONFIG_FILE_PATH = "~/.bashy/config.yml"
    
    def self.default_config
      {}
    end
    
    def self.create
      FileUtils.mkdir_p(File.dirname(CONFIG_FILE_PATH))
      
      unless File.exists?(CONFIG_FILE_PATH)
        File.open(CONFIG_FILE_PATH, "w+") do |f|
          f.write YAML.dump(self.default_config)
        end
      end
    end
    
    def self.load
      @@config ||= begin
        YAML::load_file(CONFIG_FILE_PATH) || self.default_config
      rescue Exception => e
        self.default_config
      end
    end
    
    def self.get
      
    end
    
    def self.set
    
    end
  
  end # class
end # module
