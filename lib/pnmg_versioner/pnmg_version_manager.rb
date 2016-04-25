class PnmgVersionManager

  #VERSION_FILE = "#{Rails.root}/config/initializers/version.rb"
  VERSION_FILE = "config/initializers/app_version.rb"
  attr_accessor :version
  attr_reader   :version_file


  def initialize 
    test_and_initialize_version_file
    @version_file = "#{Rails.root}/#{VERSION_FILE}"
    @version = "asdf"
  end




  ############################################################
  #   PUBLIC METHODS

  def create_version_file
    File.open(@version_file, "w") { |f| f.print("VERSION = '0.0.0.0'") }
  end

  def create_version_file!
    raise StandardError, "Version file already exists." if version_file_exists?
    create_version_file
  end

  def remove_version_file
    File.delete(@version_file) if File.file?(@version_file)
  end

  def remove_version_file! 
    raise StandardError, "Version file not found." unless version_file_exists? 
    remove_version_file
  end





  ############################################################
  #   PRIVATE METHODS
  private 


  def test_and_initialize_version_file

    #unless File.file?(VERSION_FILE)

  end






  def version_file_exists? 
    File.file?(@version_file)
  end







end