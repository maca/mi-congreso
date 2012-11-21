require 'spec_helper'

describe UserVotesController do

  let(:initiative) { mock_model(Initiative).as_null_object }
  let(:user) { mock_model(User).as_null_object }

  describe "POST 'create'" do
    before(:each) do
      controller.stub(:current_user) { user }
      Initiative.stub(:find) { initiative }
    end

    it "finds the initiative" do
      Initiative.should_receive(:find).with("1")
      post :create, initiative_id: 1
      assigns(:initiative).should eq initiative
    end

    it "creates the vote" do
      initiative.should_receive(:create_user_vote).with(user, "for")
      post :create, initiative_id: 1, value: "for"
    end
  end

end
