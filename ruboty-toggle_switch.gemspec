# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/toggle_switch/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruboty-toggle_switch'
  spec.version       = Ruboty::ToggleSwitch::VERSION
  spec.authors       = ['Naoto Takai']
  spec.email         = ['takai@recompile.net']

  spec.summary       = 'ruboty-toggle_switch allows you to toggle switch on/off.'
  spec.description   = 'ruboty-toggle_switch allows you to toggle switch on/off.'
  spec.homepage      = 'https://github.com/takai/ruboty-toggle_switch'

  spec.license       = 'Apache-2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'ruboty'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard'
end
