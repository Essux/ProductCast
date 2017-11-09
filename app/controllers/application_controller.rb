class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception
  
protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end
  helper_method :current_user, :signed_in?

private
  # Redirige al usuario a la pantalla de login si no está logueado
  def require_login
    unless current_user
      redirect_to login_url
    end
  end
end
