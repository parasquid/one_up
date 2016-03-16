# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'one_up/version'

Gem::Specification.new do |spec|
  spec.name          = "one_up"
  spec.version       = OneUp::VERSION
  spec.authors       = ["parasquid"]
  spec.email         = ["parasquid@gmail.com"]

  spec.summary       = %q{Appreciate someone by sending them a one up.}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/parasquid/one_up"
  spec.license       = ""

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rspec-given"
  spec.add_development_dependency "pry"
end
