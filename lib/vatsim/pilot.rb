module Vatsim
  # Connected pilot
  class Pilot < Client
    attr_reader :callsign, :cid, :realname, :clienttype, :latitude, :longitude, :altitude, :groundspeed, :planned_aircraft, :planned_tascruise, :planned_depairport, :planned_altitude, :planned_destairport, :server, :protrevision, :rating, :transponder, :planned_revision, :planned_flighttype, :planned_deptime, :planned_actdeptime, :planned_hrsenroute, :planned_minenroute, :planned_hrsfuel, :planned_minfuel, :planned_altairport, :planned_remarks, :planned_route, :planned_depairport_lat, :planned_depairport_lon, :planned_destairport_lat, :planned_destairport_lon, :time_logon, :heading, :QNH_iHg, :QNH_Mb

    def initialize line
      super line
      set_airport_locations
    end

    private

    # Set planned_depairport/planned_destairport latitude and longitude
    def set_airport_locations
      depairport = Vatsim::Airport.get(planned_depairport)
      destairport = Vatsim::Airport.get(planned_destairport)
      @planned_depairport_lat = depairport.nil? ? 0 : depairport.latitude
      @planned_depairport_lon = depairport.nil? ? 0 : depairport.longitude
      @planned_destairport_lat = destairport.nil? ? 0 : destairport.latitude
      @planned_destairport_lon = destairport.nil? ? 0 : destairport.longitude
    end

  end
end

