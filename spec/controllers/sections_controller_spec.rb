require 'spec_helper'

describe SectionsController do

  let(:member) { mock_model(Member, id: 1) }

  describe "GET 'index'" do
    before do
      Member.stub(:find_by_section) { member }
    end

    it "finds the member" do
      Member.should_receive(:find_by_section).with("1", "1") { member }
      get :index, state_id: "1", section_number: 1
    end

    it "redirects to the member show page" do
      get :index, state_id: "1", section_number: 1
      response.should redirect_to(member_path(1))
    end

    context "member not found" do
      it "redirects to the home page" do
        Member.stub(:find_by_section) { nil }
        get :index, state_id: "1", section_number: 1
        response.should redirect_to(root_path)
      end
    end
  end

end
