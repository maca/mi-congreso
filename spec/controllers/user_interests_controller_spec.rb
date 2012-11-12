require 'spec_helper'

describe UserInterestsController do

  let(:user) { mock_model(User).as_null_object }
  let!(:setup) { mock(:user_setup).as_null_object }

  before(:each) do
    controller.stub(:current_user) { user }
    controller.stub(:authenticate_user!) { true }
    UserSetup.stub(:new) { setup }
  end

  describe "GET new" do
    it "initializes the subjects" do
      Subject.should_receive(:all) { [] }
      get :new
      assigns(:subjects).should eq []
    end
  end

  describe "POST 'create'" do
    it "initializes a user setup" do
      UserSetup.should_receive(:new).with(user, "subject_ids" => ['1','2'], "receive_notifications" => true)
      post :create, user_setup: {subject_ids: [1,2], receive_notifications: true}
      assigns(:user_setup).should eq setup
    end

    it "saves and redirects to the initiatives" do
      setup.should_receive(:save)
      post :create
      response.should redirect_to initiatives_path
    end
  end

end
