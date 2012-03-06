class AccountsController < Devise::RegistrationsController  
  def create
    super
    if session[:omniauth]
      omniauth = session[:omniauth] 
      @user.save!
      @user.authentications.create!(provider: omniauth['provider'], uid: omniauth['uid'])
    end
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
