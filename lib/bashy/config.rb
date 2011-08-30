require 'yaml'
require 'fileutils'
require 'pathname'
require 'tempfile'

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
        @@config = self.default_config
        self.save
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
    
    def self.save
      temp_file = Tempfile.new('bashy_config.yml')
      begin
         temp_file.write(YAML.dump(@@config || self.default_config))
         temp_file.close
         FileUtils.cp(temp_file.path, CONFIG_FILE_PATH)
      ensure
        temp_file.close
        temp_file.unlink
      end
    end
    
    def self.get(key)
      self.load
      keys = key.split(".")
      keys.inject(self.load.dup) do |acc, k|
        acc = acc[k] || nil unless acc.nil?
      end
    end
    
    def self.set(key, value)
      self.load
      keys = key.split(".")
      
      config = keys.reverse.inject({}) do |acc, k|
        new_acc = {}
        if k.object_id == keys.last.object_id
          new_acc[k] = value
        else
          new_acc[k] = acc
        end
        acc = new_acc
      end
      
      @@config.deep_merge!(config)
      self.save
    end
  
  end # class
end # module
