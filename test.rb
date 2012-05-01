require './lib/vatsim.rb'

puts "There are #{Vatsim::Client.all.length} connected clients"
puts "There are #{Vatsim::Client.pilots.length} connected pilots"
puts "There are #{Vatsim::Client.atc.length} connected air traffic controllers"
puts "There are #{Vatsim::Prefile.all.length} prefiled pilots"

Vatsim::General.all.each { |p,a|
  puts "#{p} = #{a}"
}

