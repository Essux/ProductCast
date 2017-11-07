class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !!current_user
  end
  helper_method :current_user, :signed_in?

end
