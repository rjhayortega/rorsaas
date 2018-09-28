class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  # around_action :set_time_zone, if: :current_user
  protected
    def after_sign_in_path_for(resource)
      # request.env['omniauth.origin'] || stored_location_for(resource) || root_path
      # request.env['omniauth.origin'] || "http://app.houseq.io/index.php?type=login&token=" + current_user.authentication_token
      request.env['omniauth.origin'] || request.original_url[0..request.original_url.length - request.fullpath.length - 1] + "?type=login&token=" + current_user.authentication_token
    end

  private

  def ensure_organisation
    unless current_user.organisation.present?
      redirect_to new_organisation_path
    end
  end

  def after_sign_out_path_for(resource)
    request.referrer
  end

  def authenticate_admin
    unless current_user&.is_web_admin?
      # redirect_back fallback_location: 'http://app.houseq.io/'
      redirect_back fallback_location: request.host
    end
  end

  def authenticate_user_from_token!
    user_token = params[:token].presence
    if user_token
      sign_out current_user if user_signed_in?
      user = user_token && User.find_by_authentication_token(user_token.to_s)

      if user
        # Notice we are passing store false, so the user is not
        # actually stored in the session and a token is needed
        # for every request. If you want the token to work as a
        # sign in token, you can simply remove store: false.
        sign_in user
      end
    elsif !user_signed_in?
      redirect_back fallback_location: new_user_session_path
    end
  end

  # def set_time_zone(&block)
  #   if current_user.timezone
  #     Time.use_zone(current_user.timezone, &block)
  #   end

  #   yield
  # end
end
