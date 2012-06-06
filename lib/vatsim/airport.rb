require 'zlib'

module Vatsim
  # Airport
  class Airport

    attr_reader :icao, :latitude, :longitude

    # Cache of Airports already looked up to prevent searching for it again.
    @@airport_cache = nil

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
      return self.airport_cache[icao]
    end

    private

    # Returns Hash of airport instances
    def self.airport_cache
      if @@airport_cache.nil?
        @@airport_cache ||= Hash.new
        Zlib::GzipReader.open(File.dirname(__FILE__) + "/airports.gz").read.split("\n").each { |line|
          airport = Airport.new(line)
          @@airport_cache.store(airport.icao, airport)
        }
      end
      @@airport_cache
    end
  end
end

