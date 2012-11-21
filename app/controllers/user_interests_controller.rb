class UserInterestsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @subjects = Subject.all
  end

  def create
    @user_setup = UserSetup.new(current_user, params[:user_setup])
    @user_setup.save
    redirect_to stored_location_for(:user) || initiatives_path
  end
end
