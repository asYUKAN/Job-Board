class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  

  
  
  
   
   def index
   end


  
  protected

  def after_sign_in_path_for(resource)
    job_posts_path
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :contact, :resume_link])
  end
end
