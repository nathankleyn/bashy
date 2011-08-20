require 'spec_helper'

describe Bashy::Logger, "Logging class for printing to stdout and the log file" do
  
  subject do
    Bashy::Logger
  end
  
  before(:all) do
    StubHelper::stub_config
  end
  
  after(:all) do
    StubHelper::unstub_config
  end
  
  before(:each) do
    @log_file_path = File.join(Bashy::Config::CONFIG_DIR_PATH, "bashy.log")
    FileUtils.mkdir_p(File.dirname(@log_file_path))
    FileUtils.touch(@log_file_path)
    @log_file = File.open(@log_file_path, "w+")
  end
  
  after(:each) do
    @log_file.close
  end
  
  describe "#path" do
    
    it "should return the path to the log file" do
      subject.path.should eql(@log_file_path)
    end # it
    
  end # describe
  
  describe "#<<" do
    
    it "should write the given line to the log file" do
      log_message = "hello"
      subject << log_message
      @log_file.read.should eql("#{log_message}\n")
    end # it
    
  end # describe
  
  
end # describe
