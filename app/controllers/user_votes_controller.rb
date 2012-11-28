class UserVotesController < ApplicationController
  def create
    @initiative = Initiative.find(params[:initiative_id])
    @initiative.create_user_vote(current_user, params[:value])
  end
end
