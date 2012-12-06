require 'spec_helper'

describe Assistance do

  let(:assistance) { FactoryGirl.build(:assistance) }

  context "validations" do
    it "should not be valid without a member_id" do
      assistance.member_id = nil
      assistance.should_not be_valid
    end

    it "should not be valid without a session_id" do
      assistance.session_id = nil
      assistance.should_not be_valid
    end

    it "should not be valid without a value" do
      assistance.value = nil
      assistance.should_not be_valid
    end
  end

  describe ".create_from_scraper" do
    let(:member_assistance) { mock(:member_assistance, name: "Pancho", value: "asistencia") }
    let!(:member) { FactoryGirl.create(:member, name: "Pancho") }
    let!(:session) { FactoryGirl.create(:session, number: 1) }

    it "finds the member by name" do
      Member.should_receive(:find_by_name).with("Pancho") { member }
      Assistance.create_from_scraper(session, member_assistance)
    end

    it "creates a assistance" do
      VoteValue.stub(:to_i).with("asistencia") { 1 }
      assistance = Assistance.create_from_scraper(session, member_assistance)
      assistance.member_id.should eq member.id
      assistance.session_id.should eq session.id
      assistance.value.should eq 1
    end

    it "returns nil when member is not found" do
      Member.stub(:find_by_name).with("Pancho") { nil }
      Assistance.create_from_scraper(session, member_assistance).should be_nil
    end
  end
end
