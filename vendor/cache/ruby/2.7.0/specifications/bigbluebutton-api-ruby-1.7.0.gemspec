# -*- encoding: utf-8 -*-
# stub: bigbluebutton-api-ruby 1.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bigbluebutton-api-ruby".freeze
  s.version = "1.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mconf".freeze, "Leonardo Crauss Daronco".freeze]
  s.date = "2018-08-17"
  s.description = "Provides methods to access BigBlueButton in a ruby application through its API".freeze
  s.email = ["contact@mconf.org".freeze, "leonardodaronco@gmail.com".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE".freeze, "LICENSE_003".freeze, "CHANGELOG.md".freeze]
  s.files = ["CHANGELOG.md".freeze, "LICENSE".freeze, "LICENSE_003".freeze, "README.md".freeze]
  s.homepage = "https://github.com/mconf/bigbluebutton-api-ruby/".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "BigBlueButton integration for ruby".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<xml-simple>.freeze, ["~> 1.1"])
  else
    s.add_dependency(%q<xml-simple>.freeze, ["~> 1.1"])
  end
end
