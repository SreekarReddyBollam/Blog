# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from BlogExceptions::UnAuthorizedError, with: :deny_access

  include ActionController::Cookies

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def decoded_token
    token = cookies[:token]
    if token
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['id']
      User.current_user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    raise BlogExceptions::UnAuthorizedError unless logged_in?
  end

  private

  def deny_access(exception)
    render json: {
      'error': exception.message
    }, status: :unauthorized
  end

  def bad_request(exception)
    render json: {
      'error': exception.message
    }, status: :bad_request
  end

  def wrong_details(exception)
    render json: {
      'error': exception.message
    }, status: :bad_request
  end
end
