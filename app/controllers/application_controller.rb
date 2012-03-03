class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def permission_denied
    flash[:error] = "Sorry, you not allowed to access that page."
    redirect_to root_url
  end
  
end
