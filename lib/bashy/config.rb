require 'yaml'
require 'fileutils'
require 'pathname'

module Bashy
  class Config
    
    CONFIG_DIR_PATH = File.expand_path("~/.bashy")
    CONFIG_FILE_PATH = File.join(CONFIG_DIR_PATH, "config.yml")
    
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
      self.create
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
