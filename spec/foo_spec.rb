require 'spec_helper'
require 'rake'


#describe "Foobar" do
#  pending "write it"
#end
#
#
#describe "thing" do 
#  it "does something" do
#    puts "ok"
#  end
#end
#
#
#describe "bar" do 
#  it "should empty thing" do
#    #Hash.new.should == {a: 1}
#    expect(Hash.new).to eql({})
#  end
#end




#describe 'version namespace rake task' do 
#  before :all do 
#    Rake.application.rake_require "tasks/version"
#    Rake::Task.define_task(:environment) 
#  end
#
#  describe "version:test" do 
#    let :run_rake_task do
#      Rake::Task["version:test"].reenable
#      Rake.application.invoke_task "version:test"
#    end
#
#    it "should run" do 
#      run_rake_task
#    end
#
#
#  end
#
#end