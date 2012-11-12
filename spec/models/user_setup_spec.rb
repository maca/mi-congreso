require "spec_helper"

describe UserSetup do
  let(:user) { FactoryGirl.create(:user) }

  describe "#save" do
    let(:subject) { FactoryGirl.create(:subject, name: "Seguridad")}

    it "stores the subject_ids for the user" do
      UserSetup.new(user, subject_ids: [subject.id]).save
      user.subject_ids.should include subject.id
    end

    it "stores the receive_notification setting and saves the user" do
      user.should_receive(:save)
      UserSetup.new(user, receive_notifications: true).save
      user.receive_notifications.should be_true
    end
  end
end