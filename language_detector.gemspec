# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'language_detector/version'

Gem::Specification.new do |gem|
  gem.name          = "ruby_ngrams_language_detector"
  gem.version       = LanguageDetector::VERSION
  gem.authors       = ["cexposito"]
  gem.email         = ["carlosexposito68@gmail.com"]
  gem.description   = %q{ngram based language detector written in ruby}
  gem.summary       = %q{ngram based language detector}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", "~> 2.6"
end
