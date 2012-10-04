require 'spec_helper'

describe Subject do
  let(:subject) { FactoryGirl.build(:subject) }

  context "validations" do
    it "should be valid with valid attributes" do
      subject.should be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      subject.should_not be_valid
    end
  end
end
