class DashboardController < ApplicationController
  before_filter :logged_in
  def logged_in
    redirect_to '/users/auth' unless current_user
  end
end
