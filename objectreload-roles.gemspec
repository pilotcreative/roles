# -*- encoding: utf-8 -*-
require File.expand_path("../lib/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "objectreload-roles"
  s.version     = Roles::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Mariusz Pietrzyk", "Mateusz Drożdżyński"]
  s.email       = ["gems@objectreload.com"]
  s.homepage    = "http://github.com/objectreload/roles"
  s.summary     = "Simple way to create roles for users."

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
