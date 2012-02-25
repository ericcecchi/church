class InternalController < ApplicationController
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
