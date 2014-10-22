# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Ivan Kocienski", "Joran Kikke"]
  gem.email         = ["ivan.kocienski@gmail.com", "joran.k@gmail.com"]
  gem.description   =
  gem.summary       = "A Ruby API client for Ingenia"
  gem.homepage      = "http://www.ingeniapi.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ingenia_api"
  gem.require_paths = ["lib"]

  gem.version       = "1.0.2"

  gem.add_dependency('rest-client')
  gem.add_dependency('json')
  gem.add_dependency('colorize')

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('webmock')
end
