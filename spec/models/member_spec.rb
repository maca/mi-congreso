require 'spec_helper'

describe Member do

  describe "#search_with_party_and_state" do
    it "searches using ransack and including the party and state information" do
      scope = Member.unscoped
      Member.should_receive(:includes).with(:party, :state) { scope }
      scope.should_receive(:search).with(party_id_eq: 1)
      Member.search_with_party_and_state(party_id_eq: 1)
    end
  end
end