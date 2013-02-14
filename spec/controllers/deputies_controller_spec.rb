require 'spec_helper'

describe DeputiesController do

  let(:search) { mock(:search).as_null_object }
  let(:deputy) { mock_model(Deputy).as_null_object }
  let(:initiative) { mock_model(Initiative).as_null_object }

  before(:each) do
    Deputy.stub(:search_with_party_and_state) { search }
  end

  describe "GET index" do
    it "searches deputies with a query" do
      Deputy.should_receive(:search_with_party_and_state).with("party_id_eq" => "1") { search }
      get :index, q: {"party_id_eq" => "1"}
    end

    it "assigns the @deputies" do
      search.stub_chain(:result, :page) { [deputy] }
      get :index, q: {"party_id_eq" => "1"}
      assigns(:deputies).should eq [deputy]
    end
  end

  describe "GET show" do
    before(:each) do
      Deputy.stub(:find) { deputy }
      Initiative.stub_chain(:with_votes, :latest) { [initiative] }
    end

    it "finds the deputy by id" do
      Deputy.should_receive(:find).with("1") { deputy }
      get :show, id: 1
      assigns(:deputy).should eq deputy
    end

    it "assigns the sponsored initiatives by the deputy" do
      deputy.should_receive(:all_initiatives) { [initiative] }
      get :show, id: 1
      assigns(:sponsored_initiatives).should eq [initiative]
    end

    it "assigns the voted initiatives by the deputy" do
      Initiative.should_receive(:with_votes)
      get :show, id: 1
      assigns(:voted_initiatives).should eq [initiative]
    end
  end
end
