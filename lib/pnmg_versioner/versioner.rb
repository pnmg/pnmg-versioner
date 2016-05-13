module PNMG
  class Versioner


    # Constants
    VERSION_FILE      = File.join("config", "initializers", "app_version.rb")
    DEFAULT_VERSION   = [0,0,0,0]
    VERSION_SEGMENTS  = {
      major:  0,
      minor:  1,
      patch:  2,
      build:  3
    }

    # Attributes
    attr_accessor :version
    attr_reader   :version_file


    ############################################################
    #   PUBLIC CLASS METHODS


    # Class initializer
    #
    def initialize 
      @version_file = File.join(Rails.root, VERSION_FILE)
      test_and_initialize_version_file
      @app_version = defined?(VERSION) ? VERSION.split('.') : DEFAULT_VERSION
    end



    # Retrieve the current version 
    #
    # @return   [String]    Current app version 
    # 
    def self.version 
      pvm = new 
      pvm.version 
    end


    ############################################################
    #   PUBLIC METHODS


    # Create the file to contain the version information
    #
    def create_version_file
      File.open(@version_file, "w") { |f| f.print("VERSION = '0.0.0.0'") }
    end



    # Create the file to contain the version information
    #
    # @raises   [StandardError]     If the file already exists
    #
    def create_version_file!
      raise StandardError, "Version file already exists." if version_file_exists?
      create_version_file
    end



    # Remove the file containing version information
    #
    def remove_version_file
      File.delete(@version_file) if version_file_exists? 
    end



    # Remove the file containing version information
    #
    # @raises [StandardError]     If the file is not found
    #
    def remove_version_file! 
      raise StandardError, "Version file not found." unless version_file_exists? 
      remove_version_file
    end



    # Sets the version for the application
    #
    # This both updates the global variable containing the app version number and
    # updates the version file in the initializers directory.
    #
    # This method accepts the version in one of two formats:
    # - An array of integers and/or hexidecimal values
    # - A string of integers and/or hexidecimal values separated by +.+
    #
    # In either format, the version must contain between 2 and 4 segments inclusively.
    #
    # @example
    #   pvm = PnmgVersionManager.new
    #   pvm.version = [1,0,1]    
    #   pvm.version = 1.1.0f123ca
    #
    # @param  value   [Array, String]   Version to set
    #
    # @raises [ArgumentError]           If the version parameter is formatted badly
    #
    def version=(value)
      value = validate_value_parameter(value)
      @app_version = value

      # Save version and update environment constant
      version_string = "VERSION = '"+version+"'\n"
      File.open(@version_file, 'w') { |f| f.print(version_string) }
      reload_version_file
    end



    # Displays the app version in string format
    #
    # @example
    #   pvm = PnmgVersionManager.new 
    #   pvm.version = [1,0,1]
    #   pvm.version # => 1.0.1
    #
    # @return [String]  Application version
    #
    def version
      @app_version.join(".")
    end


    ############################################################
    #   PRIVATE METHODS
    private 


    # Creates the version file with the default version if the file doesn't exist
    #
    def test_and_initialize_version_file
      unless version_file_exists?
        create_version_file
        version = DEFAULT_VERSION
      end
    end



    # Validates parameters provided to an update call
    #
    # @param  values  [String, Array] The Parameters provided
    # @return [Array] Valid parameters in array format
    #
    # @raise  [ArgumentError]   If there are not 2-4 version parts or if a 
    #         version part is not either numeric or hexidecimal.
    #
    def validate_value_parameter(values)
      
      # If values isn't an array, convert to array by spliting on '.'
      values = values.split('.') unless values.kind_of? Array
      
      # Validate there are the correct number of parts to the version
      unless values.length.between?(2, 4)
        raise ArgumentError, "If the value is an array, it must be between 2 and 4 elements long."
      end

      # Validate each item in version array is a string or hex value
      values.each do |value|
        unless (hex_string?(value) || intish_string?(value))
          raise ArgumentError, "#{value} must be either an integer or a hex value." 
        end
      end

      values 
    end



    # Checks if the version file exists or not
    #
    # @return   [Boolean]   If the version file exists
    #
    def version_file_exists? 
      File.file?(@version_file)
    end







    def reload_version_file 
      warn_level = $VERBOSE
      $VERBOSE = nil
      load File.join(@version_file)
      $VERBOSE = warn_level
    end


    def hex_string?(value)
      !value.to_s[/\H/]
    end


    def intish_string?(value)
      return true if value.kind_of? Integer
      test_value = value.sub(/^0+/,'')  # Remove leading zeros
      test_value.to_i.to_s === test_value
    end


  end


end
