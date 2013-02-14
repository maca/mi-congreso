class DeputiesController < ApplicationController
  def index
    @search = Deputy.search_with_party_and_state(params[:q])
    @deputies = @search.result(:distinct => true).page(params[:page])
  end

  def show
    @deputy = Deputy.find(params[:id])
    @sponsored_initiatives = @deputy.all_initiatives
    @voted_initiatives = Initiative.with_votes.latest(3)
  end

  def votes
    @deputy = Deputy.find(params[:id])
    @voted_initiatives = Initiative.with_votes.latest(50)
  end
end
