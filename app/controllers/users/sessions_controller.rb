class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # before_action :authenticate_user!, except: []
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   # super
  # end

  # DELETE /resource/sign_out
  def destroy
    sign_out(current_user)
    redirect_to new_user_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  # def create
  #   @user = User.find_or_create_from_auth_hash(auth_hash)
  #   session[:user_id] = @user.id
  #   redirect_to root_path
  # end

  # protected

  # def auth_hash
  #   request.env['omniauth.auth']
  # end

end
