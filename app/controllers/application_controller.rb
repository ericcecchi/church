class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def permission_denied
    redirect_to root_url, alert: "Sorry, you not allowed to access that page."
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  
end
