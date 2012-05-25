module Vatsim
  # Connected pilot
  class ATC < Client
    attr_reader :callsign, :cid, :realname, :clienttype, :frequency, :latitude, :longitude, :server, :protrevision, :rating, :facilitytype, :visualrange, :time_logon
  end
end

