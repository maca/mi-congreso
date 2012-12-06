require 'spec_helper'

describe Party do

  describe ".official_ids" do
    it "returns a array of official_ids" do
      FactoryGirl.create(:party, official_id: 1)
      FactoryGirl.create(:party, official_id: 2)

      Party.official_ids.should eq [1,2]
    end
  end
end
