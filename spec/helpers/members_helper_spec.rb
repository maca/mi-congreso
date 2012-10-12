require 'spec_helper'

describe MembersHelper do

  let(:party) { mock_model(Party, short_name: "PAN") }
  let(:member) { mock_model(Member, party: party) }

  describe "#party_abbr" do
    it "returns the party abbr of the member" do
      helper.party_abbr(member).should eq "pan"
    end

    it "returns nothing when the member doens't have a party" do
      member.stub(:party) { nil }
      helper.party_abbr(member).should eq ""
    end
  end
end
