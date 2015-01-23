require File.expand_path('../lib/ingenia/api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'Ingenia'
  gem.authors       = ['Retechnica Team']
  gem.email         = %w(ingenia-devs@retechnica.com)
  gem.summary       = 'Ruby API client for Ingenia'
  gem.description   = 'Permits Ruby applications to talk to Ingenia'
  gem.homepage      = 'http://www.ingeniapi.com"'
  gem.files         = `git ls-files`.split($ORS)
  gem.test_files    = gem.files.grep(/spec\//)
  gem.require_paths = %w(lib)
  gem.version       = Ingenia::Api::VERSION.dup

  gem.add_runtime_dependency 'faraday_middleware', '>= 0.8.2', '< 0.10'

  gem.add_development_dependency 'rspec', '~> 3.1.0'
  gem.add_development_dependency 'webmock', '~> 1.18.0'
  gem.add_development_dependency 'rubocop'
end
