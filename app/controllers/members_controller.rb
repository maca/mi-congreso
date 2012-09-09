class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
  end
end
