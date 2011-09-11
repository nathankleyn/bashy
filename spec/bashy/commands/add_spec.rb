require 'spec_helper'

describe Bashy::Command::Add, "The add command that is used to add snippets" do

  before(:each) do
    StubHelper::clear_config_and_commands
  end # before

  describe "#initialize" do
    
    before :each do
      @add = Bashy::Command::Add.allocate
    end
    
    it "should fire the add_gist method when a gist is added" do
      @add.should_receive(:add_gist)
      @add.send(:initialize, "test", "https://gist.github.com/1")
    end # it
    
    it "should fire the add_local method when a file is added" do
      @add.should_receive(:add_local)
      @add.send(:initialize, "test", "/home/test/hello.txt")
    end # it
    
    it "should fire the add_local method when a string of code is added" do
      @add.should_receive(:add_local)
      @add.send(:initialize, "test", "#!/usr/bin/env bash
echo 'Hello world!'")
    end # it
    
  end
  
  describe "#add_local" do
    
    it "should take a string of code and save it as a command" do
      pending
    end # it
    
    it "should take a file, open it, and save it as a command" do
      pending
    end # it
  
  end # describe
  
  describe "#add_gist" do
    
    it "should take a Gist URL, clone the contents, and save it as a command" do
      pending
    end # it
    
  end # describe
  
  describe "#add_command_line_fu" do
    
    it "should take a commandlinefu.com URL, grab the contents, and save it as a command" do
      pending
    end # it
    
  end # describe
  
end # describe
