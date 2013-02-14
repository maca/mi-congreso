require 'spec_helper'

describe SectionsController do

  let(:deputy) { mock_model(Deputy, id: 1) }

  describe "GET 'index'" do
    before do
      Deputy.stub(:find_by_section) { deputy }
    end

    it "finds the deputy" do
      Deputy.should_receive(:find_by_section).with("1", "1") { deputy }
      get :index, state_id: "1", section_number: 1
    end

    it "redirects to the deputy show page" do
      get :index, state_id: "1", section_number: 1
      response.should redirect_to(deputy_path(1))
    end

    context "deputy not found" do
      it "redirects to the home page" do
        Deputy.stub(:find_by_section) { nil }
        get :index, state_id: "1", section_number: 1
        response.should redirect_to(root_path)
      end
    end
  end

end
