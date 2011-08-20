require 'spec_helper'
require 'fileutils'

describe Bashy::Config, "The config class which manages the loading and dumping of config data" do

  subject do
    Bashy::Config
  end # subject
  
  before(:all) do
    StubHelper::stub_config
  end # before
  
  after(:all) do
    StubHelper::unstub_config
  end # after
  
  after(:each) do
    FileUtils.rm(Bashy::Config::CONFIG_FILE_PATH) if File.exists?(Bashy::Config::CONFIG_FILE_PATH)
    Bashy::Config.class_eval do
      silence_warnings do
        @@config = nil
      end
    end
  end # after

  describe "#create" do
    
    it "should create a config file when it doesn't already exist" do
      subject.create
      File.exists?(Bashy::Config::CONFIG_FILE_PATH).should be_true
    end # it
    
    it "should not overwrite a config file if it already exists" do
      FileUtils.mkdir_p(File.dirname(Bashy::Config::CONFIG_FILE_PATH))
      FileUtils.touch(Bashy::Config::CONFIG_FILE_PATH)
      
      subject.create
      
      File::Stat.new(Bashy::Config::CONFIG_FILE_PATH).size.should eql(0)
    end # it
    
  end # describe
  
  describe "#load" do
    
    it "should load the dumped file as it was serialized" do
      hash = { :hello => "world" }
      FileUtils.mkdir_p(File.dirname(Bashy::Config::CONFIG_FILE_PATH))
      File.open(Bashy::Config::CONFIG_FILE_PATH, "w+") do |f|
        f.write(YAML.dump(hash))
      end
      
      subject.load.should eql(hash)
    end # it
    
    it "should not get an exception if the file is malformed" do
      FileUtils.mkdir_p(File.dirname(Bashy::Config::CONFIG_FILE_PATH))
      File.open(Bashy::Config::CONFIG_FILE_PATH, "w+") do |f|
        f.write("*" * 100)
      end
      
      expect do
        subject.load
      end.to_not raise_error
    end # it
    
    it "should return the default hash if the file is malformed" do
      FileUtils.mkdir_p(File.dirname(Bashy::Config::CONFIG_FILE_PATH))
      File.open(Bashy::Config::CONFIG_FILE_PATH, "w+") do |f|
        f.write("  test: ['hello'")
      end
      
      subject.load.should eql(Bashy::Config.default_config)
    end # it
    
     it "should not get an exception if the file is blank" do
      FileUtils.mkdir_p(File.dirname(Bashy::Config::CONFIG_FILE_PATH))
      File.open(Bashy::Config::CONFIG_FILE_PATH, "w+") do |f|
        f.write("")
      end
      
      expect do
        subject.load
      end.to_not raise_error
    end # it
    
    it "should return the default hash if the file is blank" do
      FileUtils.mkdir_p(File.dirname(Bashy::Config::CONFIG_FILE_PATH))
      File.open(Bashy::Config::CONFIG_FILE_PATH, "w+") do |f|
        f.write("")
      end
      
      subject.load.should eql(Bashy::Config.default_config)
    end # it
    
  end # describe

  describe "#get" do
  
  end # describe
  
  describe "#set" do
  
  end # describe

end # describe
