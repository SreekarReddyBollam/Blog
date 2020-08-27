# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorized, only: %i[destroy update]
  before_action :resource_exist, only: %i[destroy update]

  rescue_from BlogExceptions::BadRequestError, with: :bad_request
  rescue_from BlogExceptions::UnAuthorizedError, with: :deny_access

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.errors.any?
      render json: {
        'error': @user.errors
      }, status: :bad_request
    else
      token = encode_token({ id: @user.id, username: @user.username })
      User.current_user = @user;
      set_token token
      render json: @user, meta: {
        token: token
      }
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      token = encode_token({ id: @user.id, username: @user.username })
      set_token token
      User.current_user = @user
      render json: @user, meta: {
        token: token
      }
    else
      raise BlogExceptions::BadRequestError, 'Please check username and password'
    end
  end

  def logout
    delete_token
    render json: {
      status: 'Done'
    }
  end

  def show
    render json: User.find_by({ id: params[:id] })
  end

  def index
    render json: User.all, include: %w[user.id user.username posts]
  end

  def update
    @user = User.find_by({ id: params[:id] })
    @user.update_columns(updatable_user_params)
    if @user.errors.any?
      render json: {
        'error': @user.errors
      }, status: :bad_request
    else
      render json: @user
    end
  end

  def destroy
    @user = User.find_by({ id: params[:id] })
    @user.destroy!
    if @user.errors.any?
      render json: {
        'error': @user.errors
      }, status: :bad_request
    else
      render json: {
        status: 'Account Deleted'
      }
    end
  end

  private

  def resource_exist
    raise BlogExceptions::BadRequestError, 'User not found' unless User.exists?({ id: params[:id] })
  end

  def user_params
    params.permit(:username, :password, :last_name, :first_name, :bio, :profile_pic)
  end

  def updatable_user_params
    hash = {}
    %i[username first_name last_name password bio profile_pic].each do |item|
      hash[item] = params[item] if params[item].present?
    end
    hash
  end

  def set_token(token)
    cookies[:token] = { value: token, expires: 1.hour.from_now }
  end

  def delete_token
    cookies.delete(:token)
  end
end
