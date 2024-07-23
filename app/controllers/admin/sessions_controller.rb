class Admin::SessionsController < Devise::SessionsController
  # Skip CSRF protection if necessary (depends on your application setup)
  # skip_before_action :verify_authenticity_token, only: [:create]

  # Optional: Customize after_sign_in_path_for if needed
  # def after_sign_in_path_for(resource)
  #   admin_root_path
  # end

  # Optional: Customize after_sign_out_path_for if needed
  # def after_sign_out_path_for(resource_or_scope)
  #   new_admin_session_path
  # end
end
