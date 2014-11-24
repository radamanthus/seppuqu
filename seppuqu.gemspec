# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seppuqu/version'

Gem::Specification.new do |spec|
  spec.name          = "seppuqu"
  spec.version       = Seppuqu::VERSION
  spec.authors       = ["Radamanthus Batnag"]
  spec.email         = ["radamanthus@gmail.com"]
  spec.description   = %q{A simple wrapper for self-terminating sidekiqs}
  spec.summary       = %q{See https://www.coffeepowered.net/2013/08/01/seppuqu-self-terminating-sidekiqs/}
  spec.homepage      = "https://github.com/radamanthus/seppuqu"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sidekiq"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
