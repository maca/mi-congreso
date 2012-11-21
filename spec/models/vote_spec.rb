require 'spec_helper'

describe Vote do
  let(:vote) { FactoryGirl.build(:vote) }

  context "validations" do
    it "should have only one initiative vote per member" do
      FactoryGirl.create(:vote, value: 1, initiative_id: 1, voter_id: 1, voter_type: "Member")

      vote = FactoryGirl.build(:vote, value: 2, initiative_id: 1, voter_id: 1, voter_type: "Member")
      vote.should_not be_valid
    end

    it "should have a voter" do
      vote.voter = nil
      vote.should_not be_valid
    end

    it "should have a value between 1 and 3" do
      vote.value = nil
      vote.should_not be_valid
    end
  end
end
