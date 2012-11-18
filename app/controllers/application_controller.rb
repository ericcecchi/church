class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def permission_denied
    redirect_to root_url, alert: "Sorry, you not allowed to access that page."
  end
  
  private
  
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  
end
