require 'spec_helper'

describe Initiative do
  let(:initiative) { FactoryGirl.build(:initiative, views_count: 0) }
  let(:search) { mock(:search).as_null_object }
  let(:relation) { mock(:relation).as_null_object }

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
      search.should_receive(:result).with(distinct: true) { relation }
      Initiative.search_with_options({"title_cont" => "Fede"})
    end

    it "scopes the initiatives for the page" do
      relation.should_receive(:page).with(1)
      Initiative.search_with_options({}, page: 1)
    end

    it "orders the initiatives by views_count" do
      relation.should_receive(:sort_order).with("views_count")
      Initiative.search_with_options({}, order: "views_count")
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
end
