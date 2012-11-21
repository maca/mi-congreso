require "spec_helper"

describe ApplicationHelper do

  describe "#flash_messages" do
    before do
      helper.stub(:flash) { {} }
      helper.stub(:params) { {} }
    end

    context "flash and params from are empty" do
      it "returns nil" do
        helper.flash_messages.should be_nil
      end
    end

    context "flash has a message" do
      it "returns a alert message" do
        helper.stub(:flash) { {alert: "Error!"} }
        helper.flash_messages.should eq %q{<div class="alert-box alert margin-top">Error!</div>}
      end

      it "returns a notice message" do
        helper.stub(:flash) { {notice: "Success!"} }
        helper.flash_messages.should eq %q{<div class="alert-box success margin-top">Success!</div>}
      end
    end

    context "params from has a message" do
      it "returns a normal alert" do
        helper.stub(:params) { {message: "something"} }
        helper.flash_messages.should eq %q{<div class="alert-box margin-top">something</div>}
      end
    end
  end
end