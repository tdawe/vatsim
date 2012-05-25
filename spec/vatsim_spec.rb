require 'spec_helper'

describe Vatsim::VERSION do
	it "should return a non nil version" do
		Vatsim::VERSION.should_not == nil
 	end
end

describe Vatsim::Data do
	it "should return correct number of clients, pilots, and atc" do
		data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    data.clients.length.should equal(501)
		data.pilots.length.should equal(379)
		data.atc.length.should equal(122)
	end

  it "should return correct number of prefiled" do
		data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    data.prefiles.length.should equal(6)
	end

  it "should return correct values for general properties" do
		data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    data.general.length.should equal(5)
    data.general["version"].should == "8"
    data.general["reload"].should == "2"
    data.general["update"].should == "20120504011745"
    data.general["atis_allow_min"].should == "5"
    data.general["connected_clients"].should == "502"
	end

  it "should return correct values for a specific client" do
    data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    client = data.clients[20]
    client.callsign.should == "ACA021"
    client.cid.should == "1216364"
    client.realname.should == "Sam Bouz CYUL"
    client.clienttype.should == "PILOT"
    client.frequency.should == ""
    client.latitude.should == "52.36574"
    client.longitude.should == "38.94341"
    client.altitude.should == "33799"
    client.groundspeed.should == "486"
    client.planned_aircraft.should == "H/A333"
    client.planned_tascruise.should == "480"
    client.planned_depairport.should == "UUEE"
    client.planned_altitude.should == "FL340"
    client.planned_destairport.should == "LTAC"
    client.server.should == "EUROPE-CW2"
    client.protrevision.should == "100"
    client.rating.should == "1"
    client.transponder.should == "3437"
    client.facilitytype.should == ""
    client.visualrange.should == ""
    client.planned_revision.should == "0"
    client.planned_flighttype.should == "I"
    client.planned_deptime.should == "0"
    client.planned_actdeptime.should == "0"
    client.planned_hrsenroute.should == "2"
    client.planned_minenroute.should == "38"
    client.planned_hrsfuel.should == "4"
    client.planned_minfuel.should == "7"
    client.planned_altairport.should == "LTBA"
    client.planned_remarks.should == " /T/"
    client.planned_route.should == "KS LUKOS 6E8 LO 6E18 DK CRDR6 FV R11 TS R808 UUOO R368 KUBOK UA279 GR UP29 SUMOL UW100 INB UM853 BUK UW71 ILHAN"
    client.planned_depairport_lat.should == "0"
    client.planned_depairport_lon.should == "0"
    client.planned_destairport_lat.should == "0"
    client.planned_destairport_lon.should == "0"
    client.atis_message.should == ""
    client.time_last_atis_received.should == ""
    client.time_logon.should == "20120503235431"
    client.heading.should == "169"
    client.QNH_iHg.should == "29.7"
    client.QNH_Mb.should == "1005"
  end
end

