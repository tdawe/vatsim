require './lib/vatsim/version.rb'

Gem::Specification.new do |s|
  s.name        	= 'vatsim'
  s.version     	= Vatsim::VERSION
  s.date        	= '2012-04-05'
  s.summary     	= "Vatsim"
  s.description 	= "Gem to retrieve Pilot/ATC online status"
  s.authors     	= ["Trevor Dawe"]
  s.email       	= 'trevor.dawe@gmail.com'
  s.files       	= ["cache/status.txt", "lib/vatsim.rb","lib/vatsim/status.rb","lib/vatsim/version.rb"]
  s.require_paths 	= ['lib','cache']
  s.homepage    	= 'https://github.com/tdawe/vatsim'
end
