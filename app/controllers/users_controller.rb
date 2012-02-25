class UsersController < ApplicationController
before_filter :authenticate_user!
rescue_from NoMethodError, :with => :no_user

  def show
    @user = User.first(conditions: {username: params[:username].downcase } )
  end
  
  private
 
  def no_user
    flash[:alert] = "The user \"" + params[:username] + "\" does not exist."
    redirect_to :root
  end
end
