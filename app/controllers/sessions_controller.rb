class SessionsController < ApplicationController
  skip_before_action :require_login
  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Bienvenido!"
    rescue
      flash[:warning] = "Ha ocurrido un error al ingresar..."
    end
    redirect_to root_path
  end
  
  def destroy
    if current_user
      session.delete(:user_id)
      flash[:success] = 'Te has desconectado correctamente!'
    end
    redirect_to root_path
  end
end