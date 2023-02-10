# frozen_string_literal: true

class Companies::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

 # GET /resource/sign_in
  def new

    redirect_to job_posts_path
    
  end

 # POST /resource/sign_in
  def create
    company = current_company 
    
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
