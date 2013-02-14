require 'spec_helper'

describe Session do

  describe "generate_assistances!" do
    let(:session) { FactoryGirl.create(:session, number: 1) }
    let(:deputy) { mock_model(Deputy) }
    let(:deputy_assistance) { mock(:deputy_assistance, name: "Pancho Lopez", value: "asistencia") }
    let(:scraper) { mock(:assistance, deputies: [deputy_assistance]) }

    before(:each) do
      Scraper::Assistances.stub(:new) { scraper }
      Party.stub(:official_ids) { [2] }
      Deputy.stub(:find_by_name) { deputy}
    end

    it "initializes a assistance scraper for every party" do
      Scraper::Assistances.should_receive(:new).once.with(session.number, 2)
      session.generate_assistances!
    end

    it "creates a new assistance" do
      Assistance.should_receive(:create_from_scraper).with(session, deputy_assistance)
      session.generate_assistances!
    end
  end
end
