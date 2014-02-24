# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Ivan Kocienski", "Joran Kikke"]
  gem.email         = ["ivan.kocienski@gmail.com", "joran.k@gmail.com"]
  gem.description   = 
  gem.summary       = "API wrapper for Ingenia"
  gem.homepage      = "http://www.ingeniapi.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nowa_api"
  gem.require_paths = ["lib"]
  
  gem.version       = "0.0.6"

  gem.add_dependency('rest-client', '~> 0')
  gem.add_dependency('json', '~> 0')
end
