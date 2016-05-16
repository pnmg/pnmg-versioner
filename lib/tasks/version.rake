require 'task_helpers/version_task_helper'

namespace :version do 


  desc "Increment the app major version by 1"
  task bump_major: :environment do |t, args| 
    VersionTaskHelper.bump_version_with_feedback(:major)
  end



  desc "Increment the app minor version by 1"
  task bump_minor: :environment do |t, args|
    VersionTaskHelper.bump_version_with_feedback(:minor)
  end



  desc "Increment the app patch version by 1"
  task bump_patch: :environment do |t, args|
    VersionTaskHelper.bump_version_with_feedback(:patch)
  end



  desc "Increment the app build version by 1"
  task bump_build: :environment do |t, args|
    VersionTaskHelper.bump_version_with_feedback(:build)
  end



  desc "Display the current version"
  task :show => [:environment] do |t, args|
    puts ""
    puts "Application version is: #{PNMG::Versioner.version}"
  end



  desc "Set version number to specific value"
  task :set, [:version] => [:environment] do |t, args|
    if args[:version].blank?
      VersionTaskHelper.display_set_usage
      next  #exit rake task
    else
      pvm = PNMG::Versioner.new
      old_version = pvm.version
      pvm.version = args[:version]
      VersionTaskHelper.display_changed_version(old_version, pvm.version)
    end
  end


  desc "Notify Bugsnag of new deployment version"
  task notify_bugsnag: :environment do |t, args|

    if Rake::Task.task_defined?("bugsnag:deploy")
      # Run the bugsnag deploy rake task 
      ENV['BUGSNAG_REVISION'] = PNMG::Versioner.version
      ENV['BUGSNAG_RELEASE_STAGE'] = "production"
      ENV['BUGSNAG_API_KEY'] = Bugsnag.configuration.api_key
      Rake::Task['bugsnag:deploy'].invoke
    else 
      puts "Bugsnag:deploy rake task not defined in project.  No notification was be sent."
    end

  end


end

