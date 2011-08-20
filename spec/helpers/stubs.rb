module StubHelper
  def self.stub_config
    silence_warnings do
      Bashy::Config.const_set("OLD_CONFIG_DIR_PATH", Bashy::Config::CONFIG_DIR_PATH)
      Bashy::Config.const_set("OLD_CONFIG_FILE_PATH", Bashy::Config::CONFIG_FILE_PATH)
      
      Bashy::Config.const_set("CONFIG_DIR_PATH", File.realpath("./tmp"))
      Bashy::Config.const_set("CONFIG_FILE_PATH", File.join(Bashy::Config::CONFIG_DIR_PATH, "test_config.yml"))
    end
  end

  def self.unstub_config
    silence_warnings do
      Bashy::Config.const_set("CONFIG_DIR_PATH", Bashy::Config::OLD_CONFIG_DIR_PATH)
      Bashy::Config.const_set("CONFIG_FILE_PATH", Bashy::Config::OLD_CONFIG_FILE_PATH)
    end
  end
end
