class MembersController < ApplicationController
  def index
    @search = Member.search_with_party_and_state(params[:q])
    @members = @search.result(:distinct => true).page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
    @sponsored_initiatives = @member.all_initiatives
    @voted_initiatives = Initiative.voted.latest(3)
  end

  def votes
    @member = Member.find(params[:id])
    @voted_initiatives = Initiative.voted.latest(50)
  end
end
