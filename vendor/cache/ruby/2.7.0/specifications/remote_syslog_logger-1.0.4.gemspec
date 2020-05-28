# -*- encoding: utf-8 -*-
# stub: remote_syslog_logger 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "remote_syslog_logger".freeze
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Eric Lindvall".freeze]
  s.date = "2018-10-10"
  s.description = "A ruby Logger that sends UDP directly to a remote syslog endpoint".freeze
  s.email = "eric@5stops.com".freeze
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze]
  s.homepage = "https://github.com/papertrail/remote_syslog_logger".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "Ruby Logger that sends directly to a remote syslog endpoint".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<syslog_protocol>.freeze, [">= 0"])
  else
    s.add_dependency(%q<syslog_protocol>.freeze, [">= 0"])
  end
end
