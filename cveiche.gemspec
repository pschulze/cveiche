# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cveiche/version'

Gem::Specification.new do |spec|
  spec.name          = 'cveiche'
  spec.version       = Cveiche::VERSION
  spec.authors       = ['Peter Schulze']
  spec.email         = ['peterkschulze@gmail.com']

  spec.summary       = 'A simple gem for finding CVE information.'
  spec.description   = 'A simple gem for finding CVE information.'
  spec.homepage      = 'https://github.com/pschulze/cveiche'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.4'

  spec.add_runtime_dependency 'net-hippie', '~> 0.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'vcr', '~> 5.0'
  spec.add_development_dependency 'webmock', '~> 3.6'
end
