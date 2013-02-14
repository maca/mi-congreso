require 'spec_helper'

describe Commission do

  let(:deputy) { FactoryGirl.create(:deputy) }
  let(:commission) { FactoryGirl.create(:commission) }

  describe "#president" do
    it "returns the deputy with the president position" do
      CommissionMembership.create(deputy_id: deputy.id, commission_id: commission.id, position: "president")
      commission.president.should eq deputy
    end

    it "returns nil when" do
      commission.president.should be_nil
    end
  end

  describe "#president_id" do
    it "deletes the current president and creates a new one" do
      CommissionMembership.create(deputy_id: deputy.id, commission_id: commission.id, position: "president")
      deputy2 = FactoryGirl.create(:deputy)
      commission.president_id = deputy2.id
      commission.save
      commission.president.should eq deputy2
    end
  end

  describe "secretaries" do
    it "returns the deputies with the secretary position" do
      CommissionMembership.create(deputy_id: deputy.id, commission_id: commission.id, position: "secretary")
      commission.secretaries.should eq [deputy]
    end

    it "returns nil when" do
      commission.secretaries.should be_empty
    end
  end

  describe "#secretary_ids" do
    it "deletes the current secretaries and creates a new ones" do
      CommissionMembership.create(deputy_id: deputy.id, commission_id: commission.id, position: "secretary")
      deputy2 = FactoryGirl.create(:deputy)
      commission.secretary_ids = [deputy2.id]
      commission.save
      commission.secretaries.should eq [deputy2]
    end
  end

  describe "members" do
    it "returns the deputies with the member position" do
      CommissionMembership.create(deputy_id: deputy.id, commission_id: commission.id, position: "member")
      commission.members.should eq [deputy]
    end

    it "returns nil when" do
      commission.members.should be_empty
    end
  end

  describe "#member_ids" do
    it "deletes the current members and creates a new ones" do
      CommissionMembership.create(deputy_id: deputy.id, commission_id: commission.id, position: "member")
      deputy2 = FactoryGirl.create(:deputy)
      commission.member_ids = [deputy2.id]
      commission.save
      commission.members.should eq [deputy2]
    end
  end
end
