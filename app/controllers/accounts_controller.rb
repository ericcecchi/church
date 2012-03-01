class AccountsController < Devise::RegistrationsController  
  def create
    super
    omniauth = session[:omniauth] 
    @user.save!
    @user.authentications.create!(provider: omniauth['provider'], uid: omniauth['uid'])
  end
  
  private
  
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
end
