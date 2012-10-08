class InitiativesController < ApplicationController
  def index
    @search = Initiative.search(params[:q])
    @initiatives = @search.result(:distinct => true).page(params[:page])
  end

  def show
    @initiative = Initiative.find(params[:id])
  end
end
