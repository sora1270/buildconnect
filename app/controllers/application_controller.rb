class ApplicationController < ActionController::Base
  before_action :authenticate_user! # すべてのアクションでユーザーが認証されていることを確認
  helper_method :admin_signed_in? # Devise ヘルパーをビューで使用可能にする

  private

  def admin_signed_in?
    current_user&.admin?
  end

  def authenticate_admin!
    redirect_to root_path unless admin_signed_in?
  end
end