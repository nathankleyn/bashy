require "spec_helper"

describe Bashy::Base, "The base class for Bashy" do

  describe "#version" do
    
    it "should return the version number as a string" do
      described_class.version.should match(/^(?:\d+\.){2}\d+$/)
    end # it
    
  end # describe

end # describe
