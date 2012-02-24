class UsersController < ApplicationController
before_filter :authenticate_user!
rescue_from NoMethodError, :with => :no_user

  def show
    @user = User.first(conditions: {name: params[:name]} )
  end
  
  private
 
  def no_user
    flash[:alert] = "The user \"" + params[:name] + "\" does not exist."
    redirect_to :root
  end
end
