# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'GemaMatriz/version'

Gem::Specification.new do |spec|
  spec.name          = "GemaMatriz"
  spec.version       = GemaMatriz::VERSION
  spec.authors       = ["Rushil Lakhani Lakhani & Waldo Nazco Torres"]
  spec.email         = ["alu0100537031@ull.edu.es"]
  spec.description   = %q{Construcción de una gema ruby para la creación de matrices dispersas y densas}
  spec.summary       = %q{Practica 9 }
  spec.homepage      = "https://github.com/alu0100537031/prct09"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
end
