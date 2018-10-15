# encoding: utf-8
class SessionsController < ApplicationController
  skip_before_action :require_login
  layout 'blank'

  def new
  end

  def create
    user = User.find_by_email(params[:sessions][:email].downcase)
    if user.present? and user.role?(:pending)
      redirect_to register_message_users_path user
      return
    end

    if authenticated?(user, params[:sessions][:password])
      login user
      redirect_to root_path
    else
      redirect_to new_session_path, alert: 'Email o contraseña inválido'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private
    def authenticated?(user, password)
      user && user.authenticate(password)
    end
end
