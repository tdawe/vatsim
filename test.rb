require './lib/vatsim.rb'

puts "There are #{Vatsim::Client.all.length} connected clients"
puts "There are #{Vatsim::Client.pilots.length} connected pilots"
