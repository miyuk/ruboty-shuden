lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruboty/shuden/version"

Gem::Specification.new do |spec|
  spec.name          = "ruboty-shuden"
  spec.version       = Ruboty::Shuden::VERSION
  spec.authors       = ["miyuk"]
  spec.email         = ["enough7531@gmail.com"]
  spec.summary       = "Tell last train"
  spec.homepage      = "https://github.com/miyuk/ruboty-shuden"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri"
	spec.add_dependency "ruboty"
  spec.add_dependency "ruboty-redis"
  spec.add_dependency "ruboty-slack_rtm"
  spec.add_development_dependency "bundler"
	spec.add_development_dependency "rake"


end
