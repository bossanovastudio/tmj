# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crawler_socialnetwork/version'

Gem::Specification.new do |spec|
  spec.name          = "crawler_socialnetwork"
  spec.version       = CrawlerSocialnetwork::VERSION
  spec.authors       = ["Adão Raul"]
  spec.email         = ["adao.raul@gmail.com"]

  spec.summary       = "Social Network Crawler"
  spec.description   = spec.summary
  spec.homepage      = "http://github.com/adaoraul"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "twitter", "~>5.15.0"
  spec.add_runtime_dependency "koala", "~>2.5.0rc1"
  spec.add_runtime_dependency "pg", "~> 0.18"
  spec.add_runtime_dependency "activerecord", "~> 5.0.0"
  spec.add_runtime_dependency "google-api-client", "~>0.8.6"
  spec.add_runtime_dependency "pinterest-api", "~>0.2.2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "dotenv", "~> 2.1.1"
  spec.add_development_dependency "pry-meta"
end
