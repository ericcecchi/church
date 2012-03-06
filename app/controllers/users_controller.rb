class UsersController < ApplicationController
  # CanCan authorization for User class
  load_and_authorize_resource
 
  def index
    @users = User.accessible_by(current_ability, :index).limit(20)
    respond_to do |format|
      format.json { render :json => @users }
      format.xml  { render :xml => @users }
      format.html
    end
  end

  def show
    @user = User.first(conditions: { username: params[:display_name].downcase })
    if @user
      respond_to do |format|
        format.json { render :json => @user }
        format.xml  { render :xml => @user }
        format.html      
      end
    else
      flash[:alert] = "The page you are looking for does not exist."
      redirect_to root_path
    end
  end
 
  def edit
    @user = User.first(conditions: { username: params[:display_name].downcase })
  end

  def destroy
    @user = User.first(conditions: { username: params[:display_name].downcase })
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to root_path
    end
  end

  def create
    @user = User.new(params[:user])
 
    if @user.save
      respond_to do |format|
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml  { head :ok }
        format.html { redirect_to :action => :index }
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml  { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
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
        redirect_to short_profile_path(params[:user][:display_name])
      else
        redirect_to manage_users_path
      end
    else
      render :action => 'edit'
    end
  end
end
