require 'spec_helper'

describe Initiative do
  let(:initiative) { FactoryGirl.build(:initiative, views_count: 0) }

  describe "#increase_views_count!" do
    before(:each) do
      initiative.save
    end

    it "should increase the views count by 1" do
      initiative.increase_views_count!
      initiative.reload
      initiative.views_count.should eq 1
    end
  end
end
