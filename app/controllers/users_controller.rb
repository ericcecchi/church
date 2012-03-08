class UsersController < ApplicationController
  # CanCan authorization for User class
  load_and_authorize_resource
 
  def index
    @users = User.accessible_by(current_ability, :index).limit(20)
  end

  def show
    @user = User.first(conditions: { username: params[:display_name].downcase })
    if @user.nil?
      flash[:alert] = "The page you are looking for does not exist."
      redirect_to root_path
    end
  end
 
  def edit
    @user = User.first(conditions: { username: params[:display_name].downcase })
  end
  
  def new
    @community_group = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @community_group }
    end    
  end
  
  def destroy
    @user = User.first(conditions: { username: params[:display_name].downcase })
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to root_path
    end
  end

  def create
    if can? :manage, User
      @user = User.new(params[:user])
      @user.display_name = @user.first_name + @user.last_name
      @user.password = Digest::SHA1.hexdigest Time.now.to_s
    end
    if @user.save
      redirect_to manage_users_path
    else
      render :action => :new, :status => :unprocessable_entity
    end
  end
  
  def update
    @user = User.first(conditions: { username: params[:display_name].downcase })
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      if @user == current_user
        sign_in @user, :bypass => true # Bypass authentication in case password was changed
        redirect_to user_path(@user.display_name)
      else
        redirect_to manage_users_path
      end
    else
      render :action => 'edit'
    end
  end
end
