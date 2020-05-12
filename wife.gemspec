# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift(lib) unless $:.include?(lib)
require 'wife/version'

Gem::Specification.new do |s|
  s.name          = 'wife'
  s.version       = Wife::VERSION.to_s
  s.platform      = Gem::Platform::RUBY
  s.authors       = ['Benjamin Kammerl']
  s.email         = ['benny@itws.de']
  s.description   = 'Beefs. No matter how hard you try, this gem will always find something to do in your project. It tells you what you can do on a project, whats missing, errors, stuff.'
  s.summary       = s.description
  s.homepage      = 'https://github.com/phortx/wife'
  s.license       = 'MIT'

  s.required_ruby_version     = '>= 2.7'

  s.files         = `git ls-files`.split($/)
  s.require_paths = ['lib']
  s.executables   = ['wife']
  s.extra_rdoc_files = ['README.md']

  s.add_runtime_dependency 'colored'

  s.add_development_dependency 'rake', '~> 12.3.3'
end
