module Vatsim
  # General properties from vatsim data file
  class General

    # Returns all general properties
    def self.all data = nil
      data = Vatsim::Data.new if data.nil?
      data.general
    end

  end
end

