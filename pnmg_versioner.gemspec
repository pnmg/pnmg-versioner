$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pnmg_versioner/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pnmg_versioner"
  s.version     = PnmgVersioner::VERSION
  s.authors     = ["Dave Dankel"]
  s.email       = ["ddankel@gmail.com"]
  s.homepage    = "http://pnmg.com"
  s.summary     = "Rails Application version management."
  s.description = "Rails Application version management.  For internal use only."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency 'rails', '~> 0'
  s.add_development_dependency 'sqlite3', '~> 0'
  s.add_development_dependency 'rspec-rails', '~> 0'
end
