require 'spec_helper'

describe PnmgVersionManager do 

  # Define Helpers
  let(:pvm) { PnmgVersionManager.new }
  let(:remove_version_file)   { pvm.remove_version_file }
  let(:create_version_file)   { pvm.create_version_file }
  let(:version_file_exists?)  { File.file? pvm.version_file }



  describe ".new" do 

    it "without exsting version file" do 
      remove_version_file
      expect(pvm).to be_kind_of(PnmgVersionManager)
    end


    it "with existing version file" do 
      create_version_file
      expect(pvm).to be_kind_of(PnmgVersionManager)
    end

  end   # describe ".new"



  describe "#create_version_file" do

    it "without existing version file" do
      remove_version_file
      create_version_file
      expect(version_file_exists?).to be true
    end


    it "with existing version file" do 
      create_version_file 
      create_version_file
      expect(version_file_exists?).to be true
    end

    #specify("Test thing") { true.to be true }
    
  end   # describe "#create_version_file"



  describe "#create_version_file!" do 

    it "without existing verion file" do 
      remove_version_file 
      pvm.create_version_file!
      expect(version_file_exists?).to be true
    end


    it "with existing verion file" do 
      create_version_file 
      expect { pvm.create_version_file! }.to raise_error(StandardError, "Version file already exists.")      
    end

  end  # describe "#create_version_file!"



  describe "#remove_version_file" do 

    it "without existing version file" do
      remove_version_file
      remove_version_file
      expect(version_file_exists?).to be false
    end


    it "with existing version file" do 
      create_version_file 
      remove_version_file
      expect(version_file_exists?).to be false
    end

  end   # describe "#remove_version_file"



  describe "#remove_version_file!" do 

    it "without existing verion file" do 
      remove_version_file
      expect { pvm.remove_version_file! }.to raise_error(StandardError, "Version file not found.")      
    end


    it "with existing verion file" do 
      create_version_file
      pvm.remove_version_file! 
      expect(version_file_exists?).to be false
    end

  end   # describe "#remove_version_file!"



#    it "should default to 0.0.0.0 if no version yet" do
#      remove_version_file
#      pvm = PnmgVersionManager.new 
#    end


  


end
