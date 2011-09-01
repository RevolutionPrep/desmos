# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{desmos}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Ryan Moran}]
  s.date = %q{2011-09-01}
  s.description = %q{TODO: longer description of your gem}
  s.email = %q{ryan.moran@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "desmos.gemspec",
    "lib/desmos.rb",
    "lib/desmos/configuration.rb",
    "lib/desmos/errors.rb",
    "lib/desmos/request_support.rb",
    "lib/desmos/student.rb",
    "lib/desmos/tutor.rb",
    "lib/desmos/utils.rb",
    "lib/desmos/whiteboard.rb",
    "spec/desmos_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/RevolutionPrep/desmos}
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{TODO: one-line summary of your gem}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
      s.add_runtime_dependency(%q<oauth>, ["~> 0.4.5"])
      s.add_development_dependency(%q<rspec>, ["= 2.6.0"])
      s.add_development_dependency(%q<jeweler>, ["= 1.6.0"])
      s.add_development_dependency(%q<autotest>, ["= 4.4.6"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
      s.add_dependency(%q<oauth>, ["~> 0.4.5"])
      s.add_dependency(%q<rspec>, ["= 2.6.0"])
      s.add_dependency(%q<jeweler>, ["= 1.6.0"])
      s.add_dependency(%q<autotest>, ["= 4.4.6"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<yajl-ruby>, ["~> 0.8.2"])
    s.add_dependency(%q<oauth>, ["~> 0.4.5"])
    s.add_dependency(%q<rspec>, ["= 2.6.0"])
    s.add_dependency(%q<jeweler>, ["= 1.6.0"])
    s.add_dependency(%q<autotest>, ["= 4.4.6"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

