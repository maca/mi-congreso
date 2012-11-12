require "spec_helper"

describe ApplicationHelper do

  describe "#flash_messages" do
    context "flash is empty" do
      before { helper.stub(:flash) { {} } }

      it "returns nil" do
        helper.flash_messages.should be_nil
      end
    end

    it "returns a alert message" do
      helper.stub(:flash) { {alert: "Error!"} }
      helper.flash_messages.should eq %q{<div class="alert-box alert margin-top">Error!</div>}
    end

    it "returns a notice message" do
      helper.stub(:flash) { {notice: "Success!"} }
      helper.flash_messages.should eq %q{<div class="alert-box success margin-top">Success!</div>}
    end
  end
end