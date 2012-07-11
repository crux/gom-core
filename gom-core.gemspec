# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'gom/core/version'

Gem::Specification.new do |s|
  s.name        = "gom-core"
  s.version     = Gom::Core::VERSION
  s.authors     = ["art+com/dirk luesebrink"]
  s.email       = ["dirk.luesebrink@artcom.de"]
  s.homepage    = "http://github.com/crux/gom-core"
  s.summary     = %q{basic GOM functionallity}
  s.description = %q{
    this gem includes stuff which is of use for the server as well as for gom
    scripting clients
  }

  # development section
  #
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-mocks'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'growl'
  if RUBY_PLATFORM.match /java/i
    s.add_development_dependency 'ruby-debug'
  else
    s.add_development_dependency 'debugger'
  end

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map do |f| 
    File.basename(f)
  end
  s.require_paths = ["lib"]
end
