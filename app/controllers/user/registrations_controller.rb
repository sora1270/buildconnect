class User::RegistrationsController < Devise::RegistrationsController
  before_action :include_genres, only: [:new, :create]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end
  
  def destroy
    super do |resource|
      # `super` が正常に処理された後に実行される
      if resource.destroyed?
        # サインアウト処理
        sign_out(resource)
        # 新規登録画面にリダイレクト
        redirect_to new_user_registration_path and return
      end
    end
  end

  protected

  # 新規登録後のリダイレクト先を指定
  def after_sign_up_path_for(resource)
    root_path # ホームのトップページにリダイレクト
  end

  private

  def include_genres
    @genres = Genre.all
  end
end