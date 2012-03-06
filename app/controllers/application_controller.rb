class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def permission_denied
    flash[:alert] = "Sorry, you not allowed to access that page."
    redirect_to root_url
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_url
  end
  
end
