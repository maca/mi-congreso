require 'spec_helper'

describe Session do

  describe "generate_assistances!" do
    let(:session) { FactoryGirl.create(:session, number: 1) }
    let(:member) { mock_model(Member) }
    let(:member_assistance) { mock(:member_assistance, name: "Pancho Lopez", value: "asistencia") }
    let(:scraper) { mock(:assistance, members: [member_assistance]) }

    before(:each) do
      Scraper::Assistances.stub(:new) { scraper }
      Party.stub(:official_ids) { [2] }
      Member.stub(:find_by_name) { member}
    end

    it "initializes a assistance scraper for every party" do
      Scraper::Assistances.should_receive(:new).once.with(session.number, 2)
      session.generate_assistances!
    end

    it "creates a new assistance" do
      Assistance.should_receive(:create_from_scraper).with(session, member_assistance)
      session.generate_assistances!
    end
  end
end
