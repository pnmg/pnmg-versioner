require 'task_helpers/version_task_helper'

namespace :version do
  namespace :bump do
    desc "Increment the app major version by 1"
    task major: :environment do |_t, _args|
      VersionTaskHelper.bump_version_with_feedback(:major)
    end



    desc "Increment the app minor version by 1"
    task minor: :environment do |_t, _args|
      VersionTaskHelper.bump_version_with_feedback(:minor)
    end



    desc "Increment the app patch version by 1"
    task patch: :environment do |_t, _args|
      VersionTaskHelper.bump_version_with_feedback(:patch)
    end



    desc "Increment the app build version by 1"
    task build: :environment do |_t, _args|
      VersionTaskHelper.bump_version_with_feedback(:build)
    end
  end


  desc "Display the current version"
  task show: [:environment] do |_t, _args|
    puts ""
    puts "Application version is: #{PNMG::Versioner.version}"
  end



  desc "Set version number to specific value"
  task :set, [:version] => [:environment] do |_t, args|
    if args[:version].blank?
      VersionTaskHelper.display_set_usage
      next  # exit rake task
    else
      pvm = PNMG::Versioner.new
      old_version = pvm.version
      pvm.version = args[:version]
      VersionTaskHelper.display_changed_version(old_version, pvm.version)
    end
  end


  desc "Notify Bugsnag of new deployment version"
  task notify_bugsnag: :environment do |_t, _args|
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
