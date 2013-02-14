require 'spec_helper'

describe Assistance do

  let(:assistance) { FactoryGirl.build(:assistance) }

  context "validations" do
    it "should not be valid without a deputy_id" do
      assistance.deputy_id = nil
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
        FactoryGirl.create(:assistance, deputy_id: 1, session_id: 1)
      end

      it "should not be valid with the same session and deputy" do
        Assistance.new(deputy_id: 1, session_id: 1, value: 1).should_not be_valid
      end

      it "should be valid with the same deputy and different session" do
        Assistance.new(deputy_id: 1, session_id: 2, value: 1).should be_valid
      end
    end
  end

  describe ".create_from_scraper" do
    let(:deputy_assistance) { mock(:deputy_assistance, name: "Pancho", value: "asistencia") }
    let!(:deputy) { FactoryGirl.create(:deputy, name: "Pancho") }
    let!(:session) { FactoryGirl.create(:session, number: 1) }

    it "finds the deputy by name" do
      Deputy.should_receive(:find_by_name).with("Pancho") { deputy }
      Assistance.create_from_scraper(session, deputy_assistance)
    end

    it "creates a assistance" do
      VoteValue.stub(:to_i).with("asistencia") { 1 }
      assistance = Assistance.create_from_scraper(session, deputy_assistance)
      assistance.deputy_id.should eq deputy.id
      assistance.session_id.should eq session.id
      assistance.value.should eq 1
    end

    it "returns nil when deputy is not found" do
      Deputy.stub(:find_by_name).with("Pancho") { nil }
      Assistance.create_from_scraper(session, deputy_assistance).should be_nil
    end
  end
end
