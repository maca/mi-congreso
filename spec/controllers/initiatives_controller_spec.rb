require 'spec_helper'

describe InitiativesController do

  let(:initiative) { mock_model(Initiative).as_null_object }
  let(:subject) { mock_model(Subject).as_null_object }
  let(:relation) { Initiative.scoped }

  before(:each) do
    Initiative.stub(:search_with_options) { [initiative] }
    Subject.stub(:popular) { [subject] }
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

    it "filters by the subject_id" do
      Initiative.stub(:search_with_options) { relation }
      relation.should_receive(:by_subject_id).with("1")
      get :index, subject_id: 1
    end

    it "assigns the @initiatives" do
      get :index, q: {"title_cont" => "Fede"}
      assigns(:initiatives).should eq [initiative]
    end

    it "fetches popular subjects and assigns them" do
      get :index
      assigns(:subjects).should eq [subject]
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
