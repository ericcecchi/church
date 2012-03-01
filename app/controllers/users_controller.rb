class UsersController < ApplicationController
  def show
    if not @user
      flash[:alert] = "The page you are looking for does not exist."
      redirect_to :root
    end
    @user = User.first(conditions: {username: params[:username].downcase } )
  end
end
