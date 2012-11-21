require 'spec_helper'

describe Initiative do
  let(:initiative) { FactoryGirl.build(:initiative, views_count: 0) }
  let(:search) { mock(:search).as_null_object }
  let(:relation) { mock(:relation).as_null_object }
  let(:subject) { mock_model(Subject).as_null_object }

  context "validations" do
    [:title, :description, :presented_at].each do |attr|
      it "should not be valid without a #{attr}" do
        initiative.send("#{attr}=", nil)
        initiative.should_not be_valid
      end
    end
  end

  describe "#search_with_options" do
    before(:each) do
      search.stub(:result) { relation }
      Initiative.stub(:search) { search }
    end

    it "initiatizes a search object with query params" do
      Initiative.should_receive(:search).with({"title_cont" => "Fede"})
      Initiative.search_with_options({"title_cont" => "Fede"})
    end

    it "returns the results of the search" do
      search.should_receive(:result) { relation }
      Initiative.search_with_options({"title_cont" => "Fede"})
    end

    it "scopes the initiatives for the page" do
      relation.should_receive(:page).with(1)
      Initiative.search_with_options({}, page: 1)
    end

    it "orders the initiatives by views_count" do
      relation.should_receive(:sort_order).with("initiatives.views_count")
      Initiative.search_with_options({}, order: "views_count")
    end

    it "defaults to ordering by updated_at" do
      relation.should_receive(:sort_order).with("initiatives.updated_at_desc")
      Initiative.search_with_options({}, {order: nil})
    end
  end

  describe "#by_subject_id" do
    let(:subject) { FactoryGirl.create(:subject) }

    it "returns initiatives by subject id" do
      initiative = FactoryGirl.create(:initiative)
      initiative.subjects << subject
      Initiative.by_subject_id(subject.id).should include(initiative)
    end
  end

  describe "#increase_views_count!" do
    before(:each) do
      initiative.save
    end

    it "should increase the views count by 1" do
      initiative.increase_views_count!
      initiative.reload
      initiative.views_count.should eq 1
    end
  end

  describe "#calculate_sponsors_count" do
    before(:each) do
      initiative.save
    end

    it "should calculate the sponsors count" do
      initiative.sponsors << FactoryGirl.create(:member)
      initiative.calculate_sponsors_count
      initiative.sponsors_count.should eq 1
    end
  end

  describe "#calculate_initiatives_count_for_subjects" do
    it "calls the calculate_initiatives_count for every subject" do
      initiative.stub(:subjects) { [subject] }
      subject.should_receive(:calculate_initiatives_count!)
      initiative.calculate_initiatives_count_for_subjects
    end
  end

  describe "#has_been_voted?" do
    before { initiative.save }

    context "initiative has member_votes" do
      before { FactoryGirl.create(:vote, initiative: initiative) }

      it "returns true" do
        initiative.has_been_voted?.should be_true
      end
    end

    context "initiative doesn't have member_votes" do
      it "returns false" do
        initiative.has_been_voted?.should be_false
      end
    end
  end

  describe "percentage_votes" do
    it "returns the percentage of votes for" do
      initiative.stub(:total_votes).with(:for) { 100 }
      initiative.percentage_votes(:for).should eq 0.20
    end
  end

  describe "#total_votes" do
    before { initiative.save }

    it "returns the total votes for" do
      FactoryGirl.create(:vote, initiative: initiative, value: 1)
      initiative.total_votes(:for).should eq 1
    end
  end

  describe "#create_user_vote" do
    let(:user) { FactoryGirl.create(:user)}
    before { initiative.save }

    it "stores the vote and links it to the user" do
      initiative.create_user_vote(user, "for")
      vote = initiative.user_votes.first
      vote.voter.should eq user
      vote.value.should eq 1
    end
  end
end
