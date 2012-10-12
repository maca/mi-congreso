class InitiativesController < ApplicationController
  def index
    @search = Initiative.search(params[:q])
    @initiatives = Initiative.search_with_options(params[:q], {page: params[:page], order: params[:order]})
  end

  def show
    @initiative = Initiative.find(params[:id])
    @initiative.increase_views_count!
  end
end
