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

  it "should return correct values for a specific pilot" do
    data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    pilot = data.clients[20]
    pilot.callsign.should == "ACA021"
    pilot.cid.should == "1216364"
    pilot.realname.should == "Sam Bouz CYUL"
    pilot.clienttype.should == "PILOT"
    pilot.latitude.should == "52.36574"
    pilot.longitude.should == "38.94341"
    pilot.altitude.should == "33799"
    pilot.groundspeed.should == "486"
    pilot.planned_aircraft.should == "H/A333"
    pilot.planned_tascruise.should == "480"
    pilot.planned_depairport.should == "UUEE"
    pilot.planned_altitude.should == "FL340"
    pilot.planned_destairport.should == "LTAC"
    pilot.server.should == "EUROPE-CW2"
    pilot.protrevision.should == "100"
    pilot.rating.should == "1"
    pilot.transponder.should == "3437"
    pilot.planned_revision.should == "0"
    pilot.planned_flighttype.should == "I"
    pilot.planned_deptime.should == "0"
    pilot.planned_actdeptime.should == "0"
    pilot.planned_hrsenroute.should == "2"
    pilot.planned_minenroute.should == "38"
    pilot.planned_hrsfuel.should == "4"
    pilot.planned_minfuel.should == "7"
    pilot.planned_altairport.should == "LTBA"
    pilot.planned_remarks.should == " /T/"
    pilot.planned_route.should == "KS LUKOS 6E8 LO 6E18 DK CRDR6 FV R11 TS R808 UUOO R368 KUBOK UA279 GR UP29 SUMOL UW100 INB UM853 BUK UW71 ILHAN"
    pilot.planned_depairport_lat.should == "0"
    pilot.planned_depairport_lon.should == "0"
    pilot.planned_destairport_lat.should == "0"
    pilot.planned_destairport_lon.should == "0"
    pilot.time_logon.should == "20120503235431"
    pilot.heading.should == "169"
    pilot.QNH_iHg.should == "29.7"
    pilot.QNH_Mb.should == "1005"
  end

  it "should return correct values for a specific ATC" do
    data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    atc = data.clients[113]
    atc.callsign.should == "CZEG_CTR"
    atc.cid.should == "1096034"
    atc.realname.should == "Brett Zubot"
    atc.clienttype.should == "ATC"
    atc.frequency.should == "132.850"
    atc.latitude.should == "53.18500"
    atc.longitude.should == "-113.86667"
    atc.server.should == "USA-N"
    atc.protrevision.should == "100"
    atc.rating.should == "5"
    atc.facilitytype.should == "6"
    atc.visualrange.should == "600"
    atc.time_logon.should == "20120504004825"
  end
end

