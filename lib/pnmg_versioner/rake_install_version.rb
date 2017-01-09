require 'rails'

module RakeInstallVersion
  class Railtie < ::Rails::Railtie
    railtie_name :pnmg_versioner

    rake_tasks do
      load "tasks/version.rake"
    end
  end
end