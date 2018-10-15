class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale, :require_login, :set_institution

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "No tienes autorización para ver esa página."
    redirect_to root_path
  end

  private
    def set_institution
      if params[:institution_id]
        @institution = Institution.find params[:institution_id]
      end
    end

    def set_locale
      save_locale if params[:locale].present?
      I18n.locale = get_locale
    end

    def save_locale
      cookies[:locale] = params[:locale]
    end

    def get_locale
      return cookies[:locale] || default_locale
    end

    def default_locale
      return 'es'
    end
end
