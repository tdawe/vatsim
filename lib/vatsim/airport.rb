require 'zlib'

module Vatsim
  # Airport
  class Airport

    attr_reader :icao, :latitude, :longitude

    # Cache of Airports already looked up to prevent searching for it again.
    @@airport_cache = Hash.new

    # Start line for each ICAO prefix. Indexing to provide quick lookups.
    @@line_numbers = {"0"=>0, "1"=>1156, "2"=>2313, "3"=>3558, "4"=>4622, "5"=>5595, "6"=>6569, "7"=>7481, "8"=>8370, "9"=>9195, "A"=>10031, "B"=>11250, "b"=>11249, "C"=>14238, "c"=>14237, "D"=>14702, "E"=>15055, "F"=>16696, "G"=>18544, "H"=>18935, "I"=>19392, "J"=>20249, "K"=>20325, "L"=>25378, "l"=>25377, "M"=>26275, "N"=>27968, "O"=>29427, "P"=>30384, "Q"=>31200, "q"=>31202, "R"=>31324, "r"=>31323, "S"=>32180, "T"=>38523, "U"=>39188, "V"=>40322, "W"=>41258, "X"=>42159, "Y"=>42387, "Z"=>44033}

    # Initialize Airport with colon delimited line
    def initialize line

      attributes = [:icao, :latitude, :longitude]

      line_split = line.strip.split(":")

      attributes.each_with_index.map { |attribute, index|
        instance_variable_set("@#{attribute}", line_split[index]) if self.respond_to?(attribute)
      }
    end

    # Returns Airport with given icao, or nil if it can't be found
    def self.get icao
      airport = nil

      return @@airport_cache[icao] if(@@airport_cache.has_key?(icao))

      file = File.open(File.dirname(__FILE__) + "/airports.gz")
      line_number = 0
      start_line_number = @@line_numbers[icao[0]]
      start_line_number = 0 if start_line_number.nil?

      Zlib::GzipReader.new(file).each_line { |line|

        if(line_number >= start_line_number)
          if line.start_with?("#{icao}:") #values[0].eql?(icao)
            values = line.split(":")
            airport = Airport.new(line)
            @@airport_cache.store(icao, airport) if !@@airport_cache.has_key?(icao)
            break
          end
        end
        line_number += 1
      }

      airport
    end
  end
end

