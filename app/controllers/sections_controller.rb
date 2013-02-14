class SectionsController < ApplicationController

  def index
    @deputy = Deputy.find_by_section(params[:section_number], params[:state_id])

    if @deputy
      redirect_to @deputy
    else
      redirect_to root_path
    end
  end
end
