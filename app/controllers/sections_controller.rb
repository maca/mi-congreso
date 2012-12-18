class SectionsController < ApplicationController

  def index
    @member = Member.find_by_section(params[:section_number], params[:state_id])

    if @member
      redirect_to @member
    else
      redirect_to root_path
    end
  end
end
