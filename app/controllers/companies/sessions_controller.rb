# frozen_string_literal: true

class Companies::SessionsController < Devise::SessionsController
 before_action :configure_sign_in_params, only: [:create, :new]

  

 # GET /resource/sign_in
  def new
    if current_user.nil?
      super 
    else 
     redirect_to new_user_session_path
    end

  end

#  # POST /resource/sign_in
  def create
   super
  end

  #DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  #If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
