require './lib/vatsim/version.rb'

Gem::Specification.new do |s|
  s.name        	= 'vatsim'
  s.version     	= Vatsim::VERSION
  s.summary     	= "Vatsim gem"
  s.description 	= "Ruby gem to retrieve Pilot/ATC online status"
  s.authors     	= ["Trevor Dawe"]
  s.email       	= 'trevor.dawe@gmail.com'
  s.files       	= `git ls-files`.split("\n")
  s.require_paths 	= ['lib']
  s.homepage    	= 'https://github.com/tdawe/vatsim'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
