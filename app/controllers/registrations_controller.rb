class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(user)
    new_user_interest_path
  end
end