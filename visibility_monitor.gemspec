
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "visibility_monitor/version"

Gem::Specification.new do |spec|
  spec.name          = "visibility_monitor"
  spec.version       = VisibilityMonitor::VERSION
  spec.authors       = ["Dylan Thacker-Smith"]
  spec.email         = ["Dylan.Smith@shopify.com"]

  spec.summary       = "Provide a hook into method visibility changes"
  spec.homepage      = "https://github.com/dylanahsmith/visibility_monitor"
  spec.license       = "MIT"

  spec.extensions    = ['ext/visibility_monitor/extconf.rb']
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "minitest", "~> 5.0"
end
