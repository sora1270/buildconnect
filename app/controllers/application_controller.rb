class ApplicationController < ActionController::Base
  before_action :set_genres
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # Devise Strong Parameters の設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :company_name, :industry
    ])
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :company_name, :industry, :profile_image
    ])
  end
  
  # ジャンルをセットするメソッド
  def set_genres
    @genres = Genre.all
  end
end