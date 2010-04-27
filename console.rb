require 'lib/dsl'
require 'lib/runner'
require 'lib/dsl/application'
require 'lib/dsl/source'
a = DSL.instance
a.run 'recipes/source.rb'
require 'recipes/environments/production'
a.run 'recipes/applications/rsearch.rb'
