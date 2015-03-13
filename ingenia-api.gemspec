# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = 'ingenia_api'
  gem.authors       = ['Retechnica Team']
  gem.email         = %w(ingenia-devs@retechnica.com)
  gem.summary       = 'A Ruby API client for Ingenia'
  gem.description   = 'A Ruby API client for Ingenia'
  gem.homepage      = 'http://www.ingeniapi.com"'
  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.require_paths = %w(lib)
  gem.version       = '1.0.5'

  gem.add_dependency 'rest-client'
  gem.add_dependency 'json'
  gem.add_dependency 'colorize'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'webmock'
end
