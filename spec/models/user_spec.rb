require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  context "validations" do
    it "is not valid without a name" do
      user.name = nil
      user.should_not be_valid
    end
  end
end