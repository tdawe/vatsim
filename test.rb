require './lib/vatsim.rb'

data = nil
#data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/spec/vatsim-data.txt")

puts "There are #{Vatsim::Client.all(data).length} connected clients"
puts "There are #{Vatsim::Client.pilots(data).length} connected pilots"
puts "There are #{Vatsim::Client.atc(data).length} connected air traffic controllers"
puts "There are #{Vatsim::Prefile.all(data).length} prefiled pilots"

Vatsim::General.all(data).each { |p,a|
  puts "#{p} = #{a}"
}

