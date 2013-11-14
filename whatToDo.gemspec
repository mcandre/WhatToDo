# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift(lib) unless $:.include?(lib)
require 'whatToDo/version'

Gem::Specification.new do |s|
  s.name          = 'whatToDo'
  s.version       = WhatToDo::VERSION.to_s
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Benjamin Kammerl']
  s.email         = ['benny@itws.de']
  s.description   = 'Helps you to get back in a project after some idle time or to contribute to a OpenSource project by telling you what you can do on the project.'
  s.summary       = ''
  s.homepage      = 'https://github.com/phortx/WhatToDo'
  s.license       = 'MIT'

  s.required_ruby_version     = '>= 2.0.0'

  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(/^spec\//)
  s.require_paths = ['lib']
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.extra_rdoc_files = ['README.md']

  s.add_development_dependency 'bundler', '~> 1.3'
  s.add_development_dependency 'rake'
end
