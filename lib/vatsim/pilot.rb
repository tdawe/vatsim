module Vatsim
  # Connected pilot
  class Pilot < Client
    attr_reader :callsign, :cid, :realname, :clienttype, :latitude, :longitude, :altitude, :groundspeed, :planned_aircraft, :planned_tascruise, :planned_depairport, :planned_altitude, :planned_destairport, :server, :protrevision, :rating, :transponder, :planned_revision, :planned_flighttype, :planned_deptime, :planned_actdeptime, :planned_hrsenroute, :planned_minenroute, :planned_hrsfuel, :planned_minfuel, :planned_altairport, :planned_remarks, :planned_route, :planned_depairport_lat, :planned_depairport_lon, :planned_destairport_lat, :planned_destairport_lon, :time_logon, :heading, :QNH_iHg, :QNH_Mb
  end
end

