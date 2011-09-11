require File.join(File.dirname(__FILE__), 'lib/bashy/base')

Gem::Specification.new do |spec|
  spec.name = 'bashy'
  spec.version = Bashy::Base.version
  spec.extra_rdoc_files = ['README.markdown']
  spec.summary = ''
  spec.description = spec.summary + ' See http://github.com/nathankleyn/bashy for more information.'
  spec.author = 'Nathan Kleyn'
  spec.email = 'nathan@unfinitydesign.com'
  spec.homepage = 'http://github.com/nathankleyn/bashy'
  spec.files = %w(README.markdown Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  spec.executables = ['bashy']
  spec.default_executable = 'bin/bashy'
  spec.require_path = "lib"
  spec.bindir = "bin"
  
  spec.add_development_dependency("rspec", "~>2.6.0")
  spec.add_development_dependency("simplecov", "~>0.4.2")
end
