class MembersController < ApplicationController
  def index
    @search = Member.includes(:party, :state).search(params[:q])
    @members = @search.result(:distinct => true).page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
  end
end
