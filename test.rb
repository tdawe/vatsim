require './lib/vatsim.rb'

puts "There are #{Vatsim::Client.all.length} connected clients"
