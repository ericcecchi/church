class AuthenticationsController < ApplicationController
	def index
	  @authentications = current_user.authentications if current_user
	end
	
	def create
# 	  render :text => request.env["omniauth.auth"].to_yaml
	  omniauth = request.env["omniauth.auth"]
	  authentication = Authentication.first(conditions: {provider: omniauth['provider'], uid: omniauth['uid']} )
	  if authentication
	    flash[:notice] = "Signed in successfully."
	    sign_in_and_redirect(:user, authentication.user)
	  elsif current_user
		current_user.authentications.find_or_create_by(provider: omniauth['provider'], uid: omniauth['uid'])
		current_user.apply_trusted_services(omniauth)
		flash[:notice] = "Authentication successful."
		redirect_to authentications_url
	  else
	    user = User.new
# 		user.apply_trusted_services(omniauth)
	    user.authentications.build(:provider => omniauth ['provider'], :uid => omniauth['uid'])
	    user.save!
	    flash[:notice] = "Signed in successfully."
	    sign_in_and_redirect(:user, user)
	  end
	end
	
	def destroy
	  @authentication = current_user.authentications.find(params[:id])
	  @authentication.destroy
	  flash[:notice] = "Successfully destroyed authentication."
	  redirect_to authentications_url
	end

end