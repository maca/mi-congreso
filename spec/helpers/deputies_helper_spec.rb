require 'spec_helper'

describe DeputiesHelper do

  let(:party) { mock_model(Party, short_name: "PAN") }
  let(:deputy) { mock_model(Deputy, party: party) }

  describe "#party_abbr" do
    it "returns the party abbr of the deputy" do
      helper.party_abbr(deputy).should eq "pan"
    end

    it "returns nothing when the deputy doens't have a party" do
      deputy.stub(:party) { nil }
      helper.party_abbr(deputy).should eq ""
    end
  end
end
