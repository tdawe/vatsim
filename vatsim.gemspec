require './lib/vatsim/version.rb'

Gem::Specification.new do |s|
  s.name        	= 'vatsim'
  s.version     	= Vatsim::VERSION
  s.summary     	= "Vatsim gem"
  s.description 	= "Ruby library for retrieving online status for Pilots and ATC connections on the VATSIM network (www.vatsim.net)"
  s.authors     	= ["Trevor Dawe"]
  s.email       	= 'trevor.dawe@gmail.com'
  s.files       	= `git ls-files`.split("\n")
  s.require_paths 	= ['lib']
  s.homepage    	= 'https://github.com/tdawe/vatsim'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'simplecov'
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
end

