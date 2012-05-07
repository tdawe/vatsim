require 'spec_helper'

describe Vatsim::VERSION do
	it "should return a non nil version" do
		Vatsim::VERSION.should_not == nil
 	end
end

describe Vatsim::Client do
	it "should return correct number of clients, pilots, and atc" do
		data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    Vatsim::Client.all(data).length.should equal(502)
		Vatsim::Client.pilots(data).length.should equal(379)
		Vatsim::Client.atc(data).length.should equal(122)
	end
end

describe Vatsim::Prefile do
  it "should return correct number of prefiled" do
		data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    Vatsim::Prefile.all(data).length.should equal(6)
	end
end

describe Vatsim::General do
  it "should return correct values for general properties" do
		data = Vatsim::Data.new("download_files" => false, "data_file_path" => File.dirname(__FILE__) + "/vatsim-data.txt")
    Vatsim::General.all(data).length.should equal(5)
    Vatsim::General.all(data)["version"].should == "8"
    Vatsim::General.all(data)["reload"].should == "2"
    Vatsim::General.all(data)["update"].should == "20120504011745"
    Vatsim::General.all(data)["atis_allow_min"].should == "5"
    Vatsim::General.all(data)["connected_clients"].should == "502"
	end
end

