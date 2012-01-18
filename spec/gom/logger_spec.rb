require File.dirname(__FILE__)+'/../spec_helper'

describe Gom::Logger do
  it "should find the class" do
    Gom::Logger.should_not == nil
  end

  describe "with a Logger" do
    before :each do
      require 'tempfile'
      @logfile = Tempfile.new(__FILE__)
      @log = Gom::Logger.new @logfile.path
    end

    it "should have a default 'I' log level" do
      @log.info self.to_s
      (line = @logfile.read).should_not == nil
      line.should =~ / I #{self.to_s}/
    end

    it "should log execeptions" do
      raise "foo" rescue @log.ex $!, "bar"
      (txt = @logfile.read).should_not == nil

      #assert_match " E RuntimeError: bar", txt, @logfile.path
      txt.should =~ / E foo: bar/
      txt.should =~ / D foo -- callstack: bar/
    end
  end
end
