# encoding: utf-8
module SessionsHelper
  def login(user)
    cookies.permanent[:auth_token] = user.auth_token
  end

  def logout
    cookies.delete :auth_token
    self.current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(auth_token: cookies[:auth_token])    
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def logged_out?
    !logged_in?
  end

  def require_login
    redirect_to new_session_path, alert: "Debes iniciar sesión" if logged_out?
  end
end
