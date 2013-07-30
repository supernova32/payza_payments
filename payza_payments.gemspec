# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payza_payments/version'

Gem::Specification.new do |spec|
  spec.name          = 'payza_payments'
  spec.version       = PayzaPayments::VERSION
  spec.authors       = ['Patricio Cano']
  spec.email         = %w(admin@insomniware.com)
  spec.description   = %q{Validate Payza IPN payments and create payment buttons}
  spec.summary       = %q{You can generate buy now and subscription buttons for your application, and then
                          validate the IPN request sent.}
  spec.homepage      = 'https://github.com/supernova32/payza_payments'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-rails'
  spec.add_dependency 'attr_required', '>= 0.0.5'
  spec.add_dependency 'httparty', '>=0.10.0'
  spec.add_dependency 'rails', '>=3.2.14'
end
