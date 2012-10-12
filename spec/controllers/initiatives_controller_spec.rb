require 'spec_helper'

describe InitiativesController do

  let(:initiative) { mock_model(Initiative).as_null_object }

  before(:each) do
    Initiative.stub(:search_with_options) { [initiative] }
  end

  describe "GET index" do
    it "searches initiatives with a query" do
      Initiative.should_receive(:search_with_options).with({"title_cont" => "Fede"}, anything)
      get :index, q: {"title_cont" => "Fede"}
    end

    it "paginates through the results" do
      Initiative.should_receive(:search_with_options).with(nil, hash_including(page: "1"))
      get :index, page: 1
    end

    it "orders the initiatives" do
      Initiative.should_receive(:search_with_options).with(nil, hash_including(order: "views_count"))
      get :index, order: "views_count"
    end

    it "assigns the @initiatives" do
      get :index, q: {"title_cont" => "Fede"}
      assigns(:initiatives).should eq [initiative]
    end
  end

  describe "GET show" do
    before(:each) do
      Initiative.stub(:find) { initiative }
    end

    it "finds the initiative by id" do
      Initiative.should_receive(:find).with("1") { initiative }
      get :show, id: 1
      assigns(:initiative).should eq initiative
    end

    it "increases the initiative views_count" do
      initiative.should_receive(:increase_views_count!)
      get :show, id: 1
    end
  end
end
