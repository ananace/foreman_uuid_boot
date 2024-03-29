# frozen_string_literal: true

require_relative 'lib/foreman_uuid_boot/version'

Gem::Specification.new do |spec|
  spec.name          = 'foreman_uuid_boot'
  spec.version       = ForemanUuidBoot::VERSION
  spec.authors       = ['Alexander Olofsson']
  spec.email         = ['alexander.olofsson@liu.se']

  spec.summary       = 'Allows booting based off of machine UUID'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/ananace/foreman_uuid_boot'
  spec.license       = 'GPL-3.0'

  spec.files         = Dir['{app,db,lib}/**/*.{rake,rb}'] + %w[LICENSE.txt Rakefile README.md]

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-minitest'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rails'
end
