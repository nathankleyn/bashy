require 'spec_helper'

describe Bashy::Cli, "The CLI class to enable console interaction" do
  
  describe "#start" do
    
    it "should call parse_arguments! and parse_commands!, and then return the Cli instance it created" do      
      described_class.class_eval do
        alias_method :parse_arguments_old!, :parse_arguments!
        alias_method :parse_commands_old!, :parse_commands!
        
        attr_reader :parse_arguments_called, :parse_commands_called
        
        def parse_commands!
          @parse_commands_called = true
          parse_commands_old!
        end
        
        def parse_arguments!
          @parse_arguments_called = true
          parse_arguments_old!
        end
      end
      
      cli = described_class.start(:arguments_base => ["add"])
      
      cli.parse_arguments_called.should be_true
      cli.parse_commands_called.should be_true
      cli.should be_a(Bashy::Cli)
    end # it
    
  end # describe
  
  describe "#parse_arguments!" do
    
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
  
  describe "#parse_commands!" do
  
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
