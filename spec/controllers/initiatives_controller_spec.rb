require 'spec_helper'

describe InitiativesController do

  let(:search) { mock(:search).as_null_object }
  let(:initiative) { mock_model(Initiative).as_null_object }

  before(:each) do
    Initiative.stub(:search) { search }
  end

  describe "GET index" do
    it "searches initiatives with a query" do
      Initiative.should_receive(:search).with("title_cont" => "Fede") { search }
      get :index, q: {"title_cont" => "Fede"}
    end

    it "assigns the @initiatives" do
      search.stub_chain(:result, :page) { [initiative] }
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
