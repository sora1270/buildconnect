class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user

  def authenticate_admin!
    redirect_to root_path unless current_user&.admin?
  end
end
