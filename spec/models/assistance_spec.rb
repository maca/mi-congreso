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

    context "uniqueness" do
      before do
        FactoryGirl.create(:assistance, member_id: 1, session_id: 1)
      end

      it "should not be valid with the same session and member" do
        Assistance.new(member_id: 1, session_id: 1, value: 1).should_not be_valid
      end

      it "should be valid with the same member and different session" do
        Assistance.new(member_id: 1, session_id: 2, value: 1).should be_valid
      end
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
