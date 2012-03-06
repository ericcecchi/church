class AdminController < ApplicationController
  before_filter :check_permissions
  
  def check_permissions
    authorize! :manage, :all
  end
  
  def index
  
  end
end
