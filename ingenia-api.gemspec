# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = 'ingenia_api'
  gem.authors       = ['Retechnica Team']
  gem.email         = %w(ingenia-devs@retechnica.com)
  gem.summary       = 'A Ruby API client for Ingenia'
  gem.description   = 'A Ruby API client for Ingenia'
  gem.homepage      = 'http://www.ingeniapi.com'
  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = %w(lib)
  gem.version       = '1.0.5'

  gem.add_runtime_dependency 'rest-client', '~> 0'
  gem.add_runtime_dependency 'json', '~> 0'
  gem.add_runtime_dependency 'colorize', '~> 0'

  gem.add_development_dependency 'rspec', '~> 0'
  gem.add_development_dependency 'webmock', '~> 0'
end
