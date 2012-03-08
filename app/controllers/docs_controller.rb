class DocsController < ApplicationController
  before_filter :check_permissions
  def check_permissions
    authorize! :manage, :all
  end
end
