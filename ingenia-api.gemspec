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
  gem.version       = '1.0.6'

  gem.add_runtime_dependency 'rest-client', '>= 1.8.0'
  gem.add_runtime_dependency 'json', '>= 1.8.3'
  gem.add_runtime_dependency 'colorize',  '>= 0.7.7'

  gem.add_development_dependency 'rspec', '>= 3.3.0'
  gem.add_development_dependency 'webmock', '>= 1.21.0'
end
