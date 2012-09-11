class UsersController < ApplicationController
  # CanCan authorization for User class
  load_and_authorize_resource find_by: :slug
	respond_to :html, :json
  before_filter :get_user, except: [:index, :new, :create]
 
  def index
  	unless params[:q].nil?
    	@users = User.where(name: /#{Regexp.escape(params[:q])}/i)
    else
    	@users = User.all
    end
    respond_to do |format|
      format.html
			format.json { render :json => @users.map(&:token_inputs) }
		end
  end
	
	def show
 		respond_with @user
	end

  def get_user
    @user = User.find_by_slug params[:id]
    if @user.nil?
      redirect_to root_path, alert: "The page you are looking for does not exist."
    end
  end
 
  def edit
 		respond_with @user
  end
  
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end    
  end
  
  def destroy
    if @user.destroy
      redirect_to manage_users_path, notice: "Successfully deleted user."
    end
  end

  def create
    if can? :manage, User
      @user = User.new(params[:user])
      @user.admin_create
    end
    if @user.save
      redirect_to manage_users_path
    else
      render :action => :new, :status => :unprocessable_entity
    end
  end
  
  def update
    @user = User.find_by_slug params[:id]
#     render json: params
    if @user.update_attributes(params[:user])
      if @user == current_user
        sign_in @user, :bypass => true # Bypass authentication in case password was changed
        redirect_to user_path(@user), notice: "Successfully updated user."
      else
        redirect_to manage_users_path, notice: "Successfully updated user."
      end
    else
      render :edit
    end
  end
end
