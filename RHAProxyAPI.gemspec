# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'RHAProxyAPI/version'

Gem::Specification.new do |spec|
  spec.name          = "RHAProxyAPI"
  spec.version       = RHAProxyAPI::VERSION
  spec.authors       = ["Drew J. Sonne"]
  spec.email         = ["drew.sonne@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://mygemserver.com'
  end

  spec.summary       = 'Interface to allow communication with HAProxy'
  spec.description   = 'This gem allows you to send commands to HAProxy to get stats, or '\
    'modify the HAProxy config. This can be integrated with an event based web service to '\
    'allow for thrid party apps to interact with HAProxy for example, to ease configuration '\
    'for elastic load balancing.'
  spec.homepage      = 'https://github.com/drewsonne/RHAProxyAPI'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
