class MembersController < ApplicationController
  def index
    @search = Member.search_with_party_and_state(params[:q])
    @members = @search.result(:distinct => true).page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
  end
end
