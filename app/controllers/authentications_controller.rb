class AuthenticationsController < ApplicationController
	def index
	  @authentications = current_user.authentications if current_user
	end
	
	def create
# 	  render :text => request.env["omniauth.auth"].to_yaml
	  omniauth = request.env["omniauth.auth"]
	  authentication = Authentication.where(provider: omniauth['provider'], uid: omniauth['uid']).first
	  if authentication
	    flash[:notice] = "Signed in successfully."
	    sign_in_and_redirect(:user, authentication.user)
	  else
		current_user.authentications.find_or_create_by(provider: omniauth['provider'], uid: omniauth['uid'])
		current_user.apply_trusted_services(omniauth)
		flash[:notice] = "Authentication successful."
		redirect_to authentications_url
	  end
	end
	
	def destroy
	  @authentication = current_user.authentications.find(params[:id])
	  @authentication.destroy
	  flash[:notice] = "Successfully destroyed authentication."
	  redirect_to authentications_url
	end

end