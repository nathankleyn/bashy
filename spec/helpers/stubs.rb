require 'fileutils'

module StubHelper
  def self.stub_config
    silence_warnings do
      Bashy::Config.const_set("OLD_CONFIG_DIR_PATH", Bashy::Config::CONFIG_DIR_PATH)
      Bashy::Config.const_set("OLD_CONFIG_FILE_PATH", Bashy::Config::CONFIG_FILE_PATH)
      
      Bashy::Config.const_set("CONFIG_DIR_PATH", File.expand_path("./tmp"))
      Bashy::Config.const_set("CONFIG_FILE_PATH", File.join(Bashy::Config::CONFIG_DIR_PATH, "test_config.yml"))
    end
  end

  def self.unstub_config
    silence_warnings do
      Bashy::Config.const_set("CONFIG_DIR_PATH", Bashy::Config::OLD_CONFIG_DIR_PATH)
      Bashy::Config.const_set("CONFIG_FILE_PATH", Bashy::Config::OLD_CONFIG_FILE_PATH)
    end
  end
  
  def self.clear_config_and_commands
    FileUtils.rm_rf(Bashy::Config::CONFIG_DIR_PATH)
    Bashy::Config.class_eval do
      @@config = nil
    end
  end
end
