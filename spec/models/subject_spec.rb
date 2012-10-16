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

  describe "#calculate_initiatives_count" do
    before(:each) do
      subject.save
    end

    it "should calculate the initiatives count" do
      subject.initiatives << FactoryGirl.create(:initiative)
      subject.calculate_initiatives_count
      subject.initiatives_count.should eq 1
    end
  end

  describe "#popular" do
    before(:each) do
      @election = FactoryGirl.create(:subject, name: "Election", initiatives_count: 1)
      @parlament = FactoryGirl.create(:subject, name: "Election", initiatives_count: 2)
    end

    it "finds and orders the subjects by popularity" do
      Subject.popular.should eq [@parlament, @election]
    end
  end
end
