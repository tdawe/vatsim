require './lib/vatsim.rb'

data = Vatsim::Data.new

puts "There are #{data.clients.length} connected clients"
puts "There are #{data.pilots.length} connected pilots"
puts "There are #{data.atc.length} connected air traffic controllers"
puts "There are #{data.prefiles.length} prefiled pilots"

data.general.each { |p,a|
  puts "#{p} = #{a}"
}

