# -*- encoding: utf-8 -*-

require File.expand_path("../lib/devise/radius_authenticatable/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "devise-multi-radius-authenticatable"
  s.version     = Devise::RadiusAuthenticatable::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Devise extension to allow authentication via one or more Radius servers"
  s.email       = "michael.zaccari@gmail.com"
  s.homepage    = "http://github.com/mzaccari/devise-radius-authenticatable"
  s.description = "A new authentication strategy named radius_authenticatable is added to the list of warden strategies when the model requests it.  The radius server information is configured through the devise initializer. One or more servers may be configured.  When a user attempts to authenticate via radius, the radiustar gem is used to perform the authentication with each server until a response is received.  This authentication strategy can be used in place of the database_authenticatable or alongside it depending on the needs of the application."
  s.authors     = ['Calvin Bascom']
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('devise', '~> 3')
  s.add_dependency('radiustar', '~> 0.0.8')

  s.add_development_dependency('rake', '~> 10.2.2')
  s.add_development_dependency('rails', '~> 4')
  s.add_development_dependency('sqlite3', '~> 1.3')
  s.add_development_dependency('rspec', '~> 2.14')
  s.add_development_dependency('rspec-rails', '~> 2.14')
  s.add_development_dependency('factory_girl', '~> 4.4')
  s.add_development_dependency('capybara', '~> 2.2.1')
  s.add_development_dependency('launchy')
  s.add_development_dependency('ammeter', '~> 0.2')
end
