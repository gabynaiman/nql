# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nql/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'nql'
  s.version       = NQL::VERSION
  s.authors       = ['Gabriel Naiman']
  s.email         = ['gabynaiman@gmail.com']
  s.description   = 'Natural Query Language built on top of ActiveRecord and Ransack'
  s.summary       = 'Natural Query Language built on top of ActiveRecord and Ransack'
  s.homepage      = 'https://github.com/gabynaiman/nql'

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'treetop', '~> 1.4'
  s.add_dependency 'activerecord', '>= 3.2.0'
  s.add_dependency 'activesupport', '>= 3.2.0'
  s.add_dependency 'ransack', '~> 0.7'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec'
end
