class ApplicationController < ActionController::Base
  before_action :authenticate_user! # すべてのアクションでユーザーが認証されていることを確認

  #helper_method :admin_signed_in? # Devise ヘルパーをビューで使用可能にする

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # 管理者かどうかを確認
  # def admin_signed_in?
  #   current_user&.admin?
  # end

  # # 管理者専用のアクションで使用するメソッド
  # def authenticate_admin!
  #   unless admin_signed_in?
  #     flash[:alert] = "管理者権限が必要です。"
  #     redirect_to root_path
  #   end
  # end

  # Devise Strong Parameters の設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :company_name, :industry
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :company_name, :industry, :profile_image
    ])
  end
end