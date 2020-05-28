# -*- encoding: utf-8 -*-
# stub: action-cable-testing 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "action-cable-testing".freeze
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vladimir Dementyev".freeze]
  s.date = "2019-02-25"
  s.description = "Testing utils for Action Cable".freeze
  s.email = ["dementiev.vm@gmail.com".freeze]
  s.homepage = "http://github.com/palkan/action-cable-testing".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Testing utils for Action Cable".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<actioncable>.freeze, [">= 5.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.10"])
    s.add_development_dependency(%q<cucumber>.freeze, ["~> 3.1.1"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec-rails>.freeze, ["~> 3.5"])
    s.add_development_dependency(%q<aruba>.freeze, ["~> 0.14.6"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.9"])
    s.add_development_dependency(%q<ammeter>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.51"])
  else
    s.add_dependency(%q<actioncable>.freeze, [">= 5.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.10"])
    s.add_dependency(%q<cucumber>.freeze, ["~> 3.1.1"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec-rails>.freeze, ["~> 3.5"])
    s.add_dependency(%q<aruba>.freeze, ["~> 0.14.6"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.9"])
    s.add_dependency(%q<ammeter>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.51"])
  end
end
