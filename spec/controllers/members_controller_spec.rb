require 'spec_helper'

describe MembersController do

  let(:search) { mock(:search).as_null_object }
  let(:member) { mock_model(Member).as_null_object }
  let(:initiative) { mock_model(Initiative).as_null_object }

  before(:each) do
    Member.stub(:search_with_party_and_state) { search }
  end

  describe "GET index" do
    it "searches members with a query" do
      Member.should_receive(:search_with_party_and_state).with("party_id_eq" => "1") { search }
      get :index, q: {"party_id_eq" => "1"}
    end

    it "assigns the @members" do
      search.stub_chain(:result, :page) { [member] }
      get :index, q: {"party_id_eq" => "1"}
      assigns(:members).should eq [member]
    end
  end

  describe "GET show" do
    before(:each) do
      Member.stub(:find) { member }
    end

    it "finds the member by id" do
      Member.should_receive(:find).with("1") { member }
      get :show, id: 1
      assigns(:member).should eq member
    end

    it "assigns the initiatives presented by the member" do
      member.should_receive(:all_initiatives) { [initiative] }
      get :show, id: 1
      assigns(:initiatives).should eq [initiative]
    end
  end
end
