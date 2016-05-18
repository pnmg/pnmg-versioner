# PNMG Version Manager

PNMG Version Manager stores a semantic version number within a rails project and allows maintenance via rake tasks.  Versions are allowed up to four segments and each segment can be represented by an integer or a hexicdecimal value.

## Install

Add the following to your project's Gemfile:

    gem 'pnmg_presenter', git: 'https://bitbucket.org/pnmg/pnmg_presenter'

Then install by running:

    bundle install

## Getting Started

PNMG Version Manager will store the application's version at `config/initializers/app_version.rb` in the following format:

    VERSION = '3.4.1'

This file will be created and set to the default of `0.0.0.0` the first time one of the rake tasks below are called.

## Usage/Examples

### Display current version

    $ rake version:show
    Application version is: 3.4.32bf1 

### Display current version

    $ rake version:set
    Usage: rake version:set[VERSION]

    VERSION may be a STRING representation of the version

    Examples:
        rake version:set[1.2.3.4]
        rake version:set[1.aed23]

    Version must include major and minor values.  Patch number will default to 0

    $ rake version:show   
    Application version is: 0.1.0
 
    $ rake version:set[1.2]

    Application version changed:
      was: 1.0
      now: 1.2

### Bump Version Segments

    $ rake version:show   
    Application version is: 1.2
        
    $ rake version:bump_build
    
    Application version changed:
      was: 1.0
      now: 1.0.0.1
    
    $ rake version:bump_patch
    
    Application version changed:
      was: 1.0.0.1
      now: 1.0.1.1
    
    $ rake version:bump_minor
    
    Application version changed:
      was: 1.0.1.1
      now: 1.1.1.1
    
    $ rake version:bump_major
    
    Application version changed:
      was: 1.1.1.1
      now: 2.1.1.1

    $ rake version:set[1.0.ae234dc]

    Application version changed:
      was: 2.1.1.1
      now: 1.0.ae234dc

    $ rake version:bump_patch

    Application version changed:
      was: 1.0.ae234dc
      now: 1.0.ae234dd

### Bugsnag Integration

If Bugsnag is installed and configured, this rake task will execute a `Bugsnag:notify` rake task, automatically passing the bugsnag API key and the current version as parameters.

    rake version:notify_bugsnag