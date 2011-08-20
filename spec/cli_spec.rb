describe Bashy::Cli, "The CLI class to enable console interaction" do

  describe "#parse_options" do
    
    it "should return no arguments if no arguments are passed" do
      subject.arguments_base = []
      parsed_arguments = subject.parse_arguments!
      
      parsed_arguments.should be_a(Hash)
      parsed_arguments.should have(0).items
    end # it
    
    it "should return the arguments in a hash that were passed" do
      subject.arguments_base = ["-v"]
      parsed_arguments = subject.parse_arguments!
      
      parsed_arguments.should eql(:version => true)
    end # it
    
    it "should return arguments with values that were passed with an equals" do
      subject.arguments_base = ["--config-dir=/foo/bar"]
      parsed_arguments = subject.parse_arguments!
      
      parsed_arguments.should eql(:config_dir => "/foo/bar")
    end # it
    
    it "should return arguments with values that were passed without an equals" do
      subject.arguments_base = %w{ --config-dir /foo/bar }
      parsed_arguments = subject.parse_arguments!
      
      parsed_arguments.should eql(:config_dir => "/foo/bar")
    end # it
    
    it "should raise an exception when a required argument and value without passing a value" do
      subject.arguments_base = ["--config-dir"]
      
      expect do
        subject.parse_arguments!
      end.to raise_error(OptionParser::MissingArgument)
    end # it
    
    it "should remove the arguments matched from the argument base" do
      subject.arguments_base = %w{ --config-dir /foo/bar }
      parsed_arguments = subject.parse_arguments!
      
      subject.arguments_base.should eql([])
    end # it
    
    it "should leave unmatched commands in the argument base" do
      subject.arguments_base = ["foo"]
      parsed_arguments = subject.parse_arguments!
      
      subject.arguments_base.should eql(["foo"])
    end # it
    
  end # describe
  
  describe "#parse_commands" do
  
    it "should return an error when no command is passed" do
      subject.arguments_base = []
      
      expect do
        subject.parse_commands!
      end.to raise_error(Bashy::CommandNotPassedError)
    end # it
    
    it "should not return an error when a command that is recognised is passed" do
      subject.arguments_base = ["add"]
      
      expect do
        subject.parse_commands!
      end.to_not raise_error
    end # it
    
    it "should raise an error if a command is passed, not recognised" do
      subject.arguments_base = ["foo"]
      
      expect do
        subject.parse_commands!
      end.to raise_error(Bashy::CommandNotFoundError)
    end # it
    
    it "should call check if the command proxy can respond to the passed command" do
      subject.arguments_base = ["foo"]
      called = false
      
      command_proxy = Bashy::CommandProxy.new(subject.options)
      command_proxy.stub(:respond_to?) do
        called = true
        false
      end
      subject.stub(:create_command_proxy) do
        command_proxy
      end
      
      expect do
        subject.parse_commands!
      end.to raise_error(Bashy::CommandNotFoundError)
      
      called.should be_true
    end # it
    
    it "should call the correct method on the command proxy if the passed command exists" do
    
    end # it
    
  end # describe
  
end # describe
