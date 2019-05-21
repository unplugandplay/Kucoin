
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kucoin/version"

Gem::Specification.new do |spec|
  spec.name          = "kucoin"
  spec.version       = Kucoin::VERSION
  spec.authors       = ["Sebastian"]
  spec.email         = ["sebastian.johnsson@gmail.com"]

  spec.summary       = %q{KuCoin Ruby API Client}
  spec.description   = %q{KuCoin Ruby REST API Client}
  spec.homepage      = "https://github.com/SebastianJ/kucoin"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",                ">= 0.15.4"  
  spec.add_dependency "faraday_middleware",     ">= 0.13.1"
  spec.add_dependency "addressable",            ">= 2.6"
  
  spec.add_development_dependency "bundler",    "~> 1.17.2"
  spec.add_development_dependency "rake",       "~> 12.3.2"
  spec.add_development_dependency "rspec",      "~> 3.8.0"
  spec.add_development_dependency "rdoc",       "~> 6.1.1"
  spec.add_development_dependency "vcr",        "~> 4.0"
  spec.add_development_dependency "webmock",    "~> 3.5.1"
  spec.add_development_dependency "pry",        "~> 0.12.2"  
end
