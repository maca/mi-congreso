require 'spec_helper'

describe Deputy do

  let(:deputy) { FactoryGirl.build(:deputy) }
  let(:initiative) { mock_model(Initiative).as_null_object }

  describe "#search_with_party_and_state" do
    it "searches using ransack and including the party and state information" do
      scope = Deputy.unscoped
      Deputy.should_receive(:includes).with(:party, :state) { scope }
      scope.should_receive(:search).with(party_id_eq: 1) { scope }
      Deputy.search_with_party_and_state(party_id_eq: 1)
    end
  end

  describe "#find_by_name" do
    it "finds a deputy by it's name" do
      deputy = FactoryGirl.create(:deputy, name: "Pancho Lopez")
      Deputy.find_by_name("Pancho Lopez").should eq deputy
    end

    it "finds a deputy by the alternate name" do
      deputy = FactoryGirl.create(:deputy, alternative_name: "Pancho Lopez")
      Deputy.find_by_name("Pancho Lopez").should eq deputy
    end
  end

  describe "#find_by_section" do
    let!(:state) { FactoryGirl.create(:state, name: "Sonora") }
    let!(:district) { FactoryGirl.create(:district, number: 1, state_id: state.id) }
    let!(:section) { FactoryGirl.create(:section, number: 1, district_id: district.id) }
    let!(:deputy) { FactoryGirl.create(:deputy, district_id: district.id) }

    it "finds the deputy by the section number" do
      Deputy.find_by_section(1, state.id).should eq deputy
    end

    it "returns nil when the section is not found" do
      Deputy.find_by_section(1, 101).should be_nil
    end
  end

  describe "#all_initiatives" do
    it "returns the initiatives where the deputy is the main sponsor" do
      deputy.should_receive(:initiatives) { [initiative] }
      deputy.all_initiatives.should eq [initiative]
    end

    it "returns all co_sponsored_initiatives by the deputy" do
      deputy.should_receive(:co_sponsored_initiatives) { [initiative] }
      deputy.all_initiatives.should eq [initiative]
    end

    it "returns a maximum of 2 initiatives" do
      deputy.stub(:initiatives) { [initiative, initiative] }
      deputy.stub(:co_sponsored_initiatives) { [initiative] }
      deputy.all_initiatives(2).size.should eq 2
    end

    it "orders the initiatives based on the presented_at date" do
      i1 = mock_model(Initiative, presented_at: Time.now-1.day)
      i2 = mock_model(Initiative, presented_at: Time.now)
      i3 = mock_model(Initiative, presented_at: Time.now-12.hours)

      deputy.stub(:initiatives) { [i1, i2] }
      deputy.stub(:co_sponsored_initiatives) { [i3] }
      deputy.all_initiatives.should eq [i2,i3,i1]
    end
  end

  describe "#assistance_stats" do
    it "initializes a deputy assistance stats object" do
      DeputyAssistanceStats.should_receive(:new).with(deputy)
      deputy.assistance_stats
    end
  end
end