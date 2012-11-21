class RegistrationsController < Devise::RegistrationsController

  def new
    session["user_return_to"] = params[:return_to] if params[:return_to].present?
    super
  end

  def after_sign_up_path_for(user)
    new_user_interest_path
  end
end