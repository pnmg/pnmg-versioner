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
  s.description = "Rails Application version management."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"

end
