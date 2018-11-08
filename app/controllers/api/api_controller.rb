class Api::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action  :set_locale, :require_login, :set_institution
  before_action :authenticate_api_user

  layout :false

  def authenticate_api_user
    authorization = request.headers["Authorization"]
    if !authorization
      render_error(message: 'Not Authenticated', type:'authentication_error', status: :unauthorized)
      return
    end

    token = authorization.split(' ').second
    if token == 'SSFuNs0cMHsDecdsS1mo-X'
      @current_institution = Institution.first
      return true
    else
      render_error(message: 'Not Authenticated', type:'authentication_error', status: :unauthorized)
      return
    end
  end

  def render_model_not_found_error(a_model_name)
    render_error(message: "#{a_model_name} not found", type: 'invalid_request_error', status: :not_found)
  end

  def render_model_error(a_model)
    error = a_model.errors.first
    message = error.join(' ')
    param = error.first.to_s

    render_error(message: message, type: 'invalid_request_error', param: param, status: :unprocessable_entity, the_class: a_model.class.to_s)
  end

  def render_error(message:, type:, param: nil, status: 500, code: nil, the_class: '')
    json = {error: {}}
    json[:error][:message] = message
    json[:error][:type] = type if type.present?
    json[:error][:param] = param if param.present?
    json[:error][:code] = code if code.present?
    json[:error][:class] = the_class if the_class.present?

    render json: json, status: status
  end
end