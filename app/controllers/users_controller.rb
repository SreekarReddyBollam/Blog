# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorized, only: %i[destroy update]
  before_action :resource_exist, only: %i[destroy update]
  rescue_from BlogExceptions::BadRequestError, with: :bad_request
  rescue_from BlogExceptions::UnAuthorizedError, with: :deny_access

  # REGISTER
  def create
    @user = User.create!(user_params)
    if @user.errors.any?
      render json: {
        'error': @user.errors
      }, status: :bad_request
    end
    token = encode_token({ user_id: @user.id })
    render json: { 'User': UserSerializer.new(@user), 'token': token }
  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user&.authenticate(params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { 'User': UserSerializer.new(@user), 'token': token }
    else
      raise BlogExceptions::BadRequestError
    end
  end

  def show
    render json: User.find_by({ id: params[:id] })
  end

  def index
    render json: User.all, include: %w[user.id user.username posts]
  end

  def update
    @user = User.find_by({ id: params[:id] })
    @user.update_columns({
                           username: params[:username],
                           first_name: params[:first_name],
                           last_name: params[:last_name]
                         })
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
    raise BlogExceptions::BadRequestError unless User.exists?({ id: params[:id] })
  end

  def user_params
    params.permit(:username, :password, :last_name, :first_name)
  end
end
