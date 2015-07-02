# encoding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano-foundation"
  gem.version       = "1.1.3"
  gem.authors       = ["Mathieu Allaire"]
  gem.email         = ["mathieu@agendrix.com"]
  gem.description   = "Provides a basic capistrano rails stack"
  gem.summary       = "Provides a basic capistrano rails stack"
  gem.homepage      = "https://github.com/agendrix/capistrano-foundation"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.require_paths = ["lib"]

  gem.add_dependency "capistrano", "~> 3.1"
  gem.add_dependency "sshkit", "~> 1.3"

end
