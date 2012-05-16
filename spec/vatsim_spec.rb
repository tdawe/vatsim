require 'spec_helper'

describe Vatsim::VERSION do
	it "should return a non nil version" do
		Vatsim::VERSION.should_not == nil
 	end
end

describe Vatsim::Data do
	it "should return correct number of clients, pilots, and atc" do
		data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    data.clients.length.should equal(502)
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
end

