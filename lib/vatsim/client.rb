module Vatsim
  class Client
    attr_reader :callsign, :cid, :realname, :clienttype, :frequency, :latitude, :longitude, :altitude, :groundspeed, :planned_aircraft, :planned_tascruise, :planned_depairport, :planned_altitude, :planned_destairport, :server, :protrevision, :rating, :transponder, :facilitytype, :visualrange, :planned_revision, :planned_flighttype, :planned_deptime, :planned_actdeptime, :planned_hrsenroute, :planned_minenroute, :planned_hrsfuel, :planned_minfuel, :planned_altairport, :planned_remarks, :planned_route, :planned_depairport_lat, :planned_depairport_lon, :planned_destairport_lat, :planned_destairport_lon, :atis_message, :time_last_atis_received, :time_logon, :heading, :QNH_iHg, :QNH_Mb

    def self.all
      Vatsim::Data.parse_clients
    end
    
    def self.pilots
      clients = Vatsim::Data.parse_clients
      pilots = Array.new
      clients.each { |client|
        pilots << client if client.clienttype.eql? "PILOT"
      }
      return pilots
    end
    
    def self.atc
      clients = Vatsim::Data.parse_clients
      atc = Array.new
      clients.each { |client|
        atc << client if client.clienttype.eql? "ATC"
      }
      return atc
    end
    
    private
    
    def initialize line
      
      attributes = [:callsign, :cid, :realname, :clienttype, :frequency, :latitude, :longitude, :altitude, :groundspeed, :planned_aircraft, :planned_tascruise, :planned_depairport, :planned_altitude, :planned_destairport, :server, :protrevision, :rating, :transponder, :facilitytype, :visualrange, :planned_revision, :planned_flighttype, :planned_deptime, :planned_actdeptime, :planned_hrsenroute, :planned_minenroute, :planned_hrsfuel, :planned_minfuel, :planned_altairport, :planned_remarks, :planned_route, :planned_depairport_lat, :planned_depairport_lon, :planned_destairport_lat, :planned_destairport_lon, :atis_message, :time_last_atis_received, :time_logon, :heading, :QNH_iHg, :QNH_Mb]
      
      #TODO split line into an array here so that it doesn't have to be split so many times
      attributes.each_with_index.map { |attribute, index|
        instance_variable_set("@#{attribute}", line.split(":")[index]) if self.respond_to?(attribute)
      }
      
    end
  end
end