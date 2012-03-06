class InternalController < ApplicationController
  before_filter :authenticate_user!
  require 'redcarpet'

  def rails
    respond_to do |format|
      format.html # rails.html.erb
    end
  end
  
  def admin_dash
  	respond_to do |format|
  	  format.html # rails.html.erb
  	end
  end
end
