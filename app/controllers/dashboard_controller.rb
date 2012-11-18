class DashboardController < ApplicationController
  before_filter :logged_in
  def logged_in
    redirect_to new_user_session_url unless current_user
  end
end
