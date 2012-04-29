require 'spec_helper'

describe Vatsim::VERSION do
	it "should return a non nil version" do
		Vatsim::VERSION.should_not == nil
    	end
end
