class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.first(conditions: {provider: omniauth['provider'], uid: omniauth['uid']} )
    if authentication
      sign_in_and_redirect(:user, authentication.user, notice: "Signed in successfully.")
    elsif current_user
      current_user.apply_omniauth(omniauth)
      current_user.authentications.create!(provider: omniauth['provider'], uid: omniauth['uid'])
      redirect_to authentications_url, notice: "Authentication successful."
    else
      @user = User.new
      @user.apply_omniauth(omniauth)
      if user.save
        @user.authentications.create!(provider: omniauth['provider'], uid: omniauth['uid'])
        sign_in_and_redirect(:user, @user, notice: "Account created successfully.")
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_registration_url
      end
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    if @authentication.destroy
      redirect_to authentications_url, notice: "Successfully destroyed authentication."
    else
      redirect_to authentications_url, notice: "Something went wrong..."
    end
  end

  protected
  
  # This is necessary since Rails 3.0.4
  # See https://github.com/intridea/omniauth/issues/185
  # and http://www.arailsdemo.com/posts/44
  def handle_unverified_request
    true
  end
  
end