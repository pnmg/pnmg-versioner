# Helper module for the +version:+ rake tasks
#
module VersionTaskHelper


  # Bump version segment passed and provide feedback on change
  #
  def bump_version_with_feedback(segment)
    pvm = PNMG::Versioner.new 
    old_version = pvm.version
    pvm.bump_version(segment)    
    display_changed_version(old_version, pvm.version)
  end


  # Display changed version message
  #
  def display_changed_version (old_version, new_version)
    puts ""
    puts "Application version changed:"
    puts "  was: #{old_version}"    
    puts "  now: #{new_version}"
  end


  # Display usage
  #
  def display_set_usage
    puts "Usage: rake version:set[FORMATTED_VERSION]"
    puts ""
    puts "FORMATTED_VERSION may be a STRING or ARRAY representation of the version"
    puts ""
    puts "Examples:"
    puts "    rake version:set[1.2.3.4]"
    puts "    rake version:set[1.aed23]"
    puts "    rake version:set[1,2,4,5]"
    puts ""
    puts "Version must include major and minor values."
    puts "Patch number will default to 0"
  end



  ######################################################################
  #   MODULE FUNCTION METHOD DECLARATIONS

  module_function :bump_version_with_feedback
  module_function :display_changed_version
  module_function :display_set_usage


end