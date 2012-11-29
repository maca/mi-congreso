require 'spec_helper'

describe Assistance do

  let(:assistance) { FactoryGirl.build(:assistance) }

  context "validations" do
    it "should not be valid without a member_id" do
      assistance.member_id = nil
      assistance.should_not be_valid
    end

    it "should not be valid without a session_id" do
      assistance.session_id = nil
      assistance.should_not be_valid
    end

    it "should not be valid without a value" do
      assistance.value = nil
      assistance.should_not be_valid
    end
  end
end
