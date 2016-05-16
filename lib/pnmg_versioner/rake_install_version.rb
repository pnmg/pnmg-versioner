module RakeInstallVersion
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/version.rake"
    end
  end
end