class UsersController < ApplicationController
  def show
    @user = User.first(conditions: {username: params[:username].downcase } )
    if not @user
      flash[:alert] = "The page you are looking for does not exist."
      redirect_to :root
    end
  end
end
