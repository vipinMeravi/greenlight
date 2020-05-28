# -*- encoding: utf-8 -*-
# stub: random_password 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "random_password".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["akinrt".freeze]
  s.bindir = "exe".freeze
  s.date = "2018-02-23"
  s.description = "\u{1F511} RandomPassword is a strong password generator that help your way to generate secure password quickly.".freeze
  s.email = ["aki.d.sc@gmail.com".freeze]
  s.homepage = "https://github.com/akinrt/random_password".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1.0".freeze)
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Generate strong passwords".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.52.1"])
    s.add_development_dependency(%q<rubocop-rspec>.freeze, ["~> 1.22.2"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.52.1"])
    s.add_dependency(%q<rubocop-rspec>.freeze, ["~> 1.22.2"])
  end
end
