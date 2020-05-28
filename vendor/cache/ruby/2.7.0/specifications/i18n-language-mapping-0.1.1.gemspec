# -*- encoding: utf-8 -*-
# stub: i18n-language-mapping 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "i18n-language-mapping".freeze
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["jfederico".freeze]
  s.bindir = "exe".freeze
  s.date = "2020-04-20"
  s.description = "List of all the known languages in their English and Native name with locales.".freeze
  s.email = ["jesus@123it.ca".freeze]
  s.homepage = "https://github.com/blindsidenetworks/i18n-language-mapping".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "List of all the known languages in their English and Native name with locales.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.16"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
