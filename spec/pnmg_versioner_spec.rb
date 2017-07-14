require 'spec_helper'

describe PNMG::Versioner do
  # Define Helpers
  let(:pvm) { PNMG::Versioner.new }
  let(:remove_version_file)   { pvm.remove_version_file }
  let(:create_version_file)   { pvm.create_version_file }
  let(:version_file_exists?)  { File.file? pvm.version_file }



  describe ".new" do
    it "without exsting version file" do
      remove_version_file
      expect(pvm).to be_kind_of(PNMG::Versioner)
    end


    it "with existing version file" do
      create_version_file
      expect(pvm).to be_kind_of(PNMG::Versioner)
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

    # specify("Test thing") { true.to be true }
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



  describe "#set_version" do
    describe "works with arrays" do
      it "of length 2 to 4" do
        expect { pvm.version = [1] }.to raise_error(ArgumentError)

        pvm.version = [10, 1123]
        expect(PNMG::Versioner.version).to eq("10.1123")

        pvm.version = [3, "7", 10]
        expect(PNMG::Versioner.version).to eq("3.7.10")

        pvm.version = [4, 89, "4115", 112]
        expect(PNMG::Versioner.version).to eq("4.89.4115.112")

        expect { pvm.version = [0, 1, 3, 1, 0] }.to raise_error(ArgumentError)
      end


      it "of integers or hex values" do
        pvm.version = [1, '34df']
        expect(PNMG::Versioner.version).to eq("1.34df")

        pvm.version = [2, 67, '3eef09']
        expect(PNMG::Versioner.version).to eq("2.67.3eef09")

        pvm.version = [1, 2, 3, 'dd345ef21']
        expect(PNMG::Versioner.version).to eq("1.2.3.dd345ef21")

        expect { pvm.version = ["g", 1] }.to    raise_error(ArgumentError)
        expect { pvm.version = [3, "t"] }.to    raise_error(ArgumentError)
        expect { pvm.version = ["4", "j"] }.to  raise_error(ArgumentError)
      end
    end


    describe "works with strings" do
      it "of length 2 to 4" do
        expect { pvm.version = "1" }.to raise_error(ArgumentError)

        valid_versions = ["10.123", "1.13.123", "1.2.0.0"]
        valid_versions.each do |ver|
          pvm.version = ver
          expect(PNMG::Versioner.version).to eq(ver)
        end

        expect { pvm.version = "1.2.3.4.5" }.to raise_error(ArgumentError)
      end


      it "of integers and hex values" do
        valid_versions = ["1.34ade3", "3ef456a.1.3", "1.2.3.234234ef"]
        valid_versions.each do |ver|
          pvm.version = ver
          expect(PNMG::Versioner.version).to eq(ver)
        end

        expect { pvm.version = "string" }.to   raise_error(ArgumentError)
        expect { pvm.version = "1.2.str" }.to  raise_error(ArgumentError)
      end
    end
  end



  describe "#bump_version" do
    it "works on integers" do
      pvm.version = "1.2.3.4"

      pvm.bump_version(:build)
      expect(pvm.version).to eq("1.2.3.5")

      pvm.bump_version(:patch)
      expect(pvm.version).to eq("1.2.4")

      pvm.bump_version(:minor)
      expect(pvm.version).to eq("1.3")

      pvm.bump_version(:major)
      expect(pvm.version).to eq("2.0")

      expect { pvm.bump_version(:not_valid) }.to raise_error(ArgumentError)

      # Try skipping a version segment

      pvm.version = "1.0"

      pvm.bump_version(:build)
      expect(pvm.version).to eq("1.0.0.1")
    end


    it "works on hex" do
      pvm.version = "1.2.32bef"
      pvm.bump_version(:patch)
      expect(pvm.version).to eq("1.2.32bf0")
    end
  end




  #        pvm.version = [5, "8", 7, "3"]
  #        expect(pvm.version).to eq("5.8.7.3")
  #        pvm.version = "2.3.2.10"
  #        expect(pvm.version).to eq("2.3.2.10")
  #


  #    it "should default to 0.0.0.0 if no version yet" do
  #      remove_version_file
  #      pvm = PNMG::Versioner.new
  #    end
end
