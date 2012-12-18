require 'spec_helper'

describe Member do

  let(:member) { FactoryGirl.build(:member) }
  let(:initiative) { mock_model(Initiative).as_null_object }

  describe "#search_with_party_and_state" do
    it "searches using ransack and including the party and state information" do
      scope = Member.unscoped
      Member.should_receive(:includes).with(:party, :state) { scope }
      scope.should_receive(:search).with(party_id_eq: 1) { scope }
      Member.search_with_party_and_state(party_id_eq: 1)
    end
  end

  describe "#find_by_name" do
    it "finds a member by it's name" do
      member = FactoryGirl.create(:member, name: "Pancho Lopez")
      Member.find_by_name("Pancho Lopez").should eq member
    end

    it "finds a member by the alternate name" do
      member = FactoryGirl.create(:member, alternative_name: "Pancho Lopez")
      Member.find_by_name("Pancho Lopez").should eq member
    end
  end

  describe "#find_by_section" do
    let!(:state) { FactoryGirl.create(:state, name: "Sonora") }
    let!(:district) { FactoryGirl.create(:district, number: 1, state_id: state.id) }
    let!(:section) { FactoryGirl.create(:section, number: 1, district_id: district.id) }
    let!(:member) { FactoryGirl.create(:member, district_id: district.id) }

    it "finds the member by the section number" do
      Member.find_by_section(1, state.id).should eq member
    end

    it "returns nil when the section is not found" do
      Member.find_by_section(1, 101).should be_nil
    end
  end

  describe "#all_initiatives" do
    it "returns the initiatives where the member is the main sponsor" do
      member.should_receive(:initiatives) { [initiative] }
      member.all_initiatives.should eq [initiative]
    end

    it "returns all co_sponsored_initiatives by the member" do
      member.should_receive(:co_sponsored_initiatives) { [initiative] }
      member.all_initiatives.should eq [initiative]
    end

    it "returns a maximum of 2 initiatives" do
      member.stub(:initiatives) { [initiative, initiative] }
      member.stub(:co_sponsored_initiatives) { [initiative] }
      member.all_initiatives(2).size.should eq 2
    end

    it "orders the initiatives based on the presented_at date" do
      i1 = mock_model(Initiative, presented_at: Time.now-1.day)
      i2 = mock_model(Initiative, presented_at: Time.now)
      i3 = mock_model(Initiative, presented_at: Time.now-12.hours)

      member.stub(:initiatives) { [i1, i2] }
      member.stub(:co_sponsored_initiatives) { [i3] }
      member.all_initiatives.should eq [i2,i3,i1]
    end
  end

  describe "#assistance_stats" do
    it "initializes a member assistance stats object" do
      MemberAssistanceStats.should_receive(:new).with(member)
      member.assistance_stats
    end
  end
end