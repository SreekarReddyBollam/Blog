# frozen_string_literal: true

class FollowersController < ApplicationController
  before_action :authorized, only: %i[update destroy]
  before_action :resource_exists, only: %i[update destroy]

  rescue_from BlogExceptions::BadRequestError, with: :bad_request
  rescue_from BlogExceptions::UnAuthorizedError, with: :deny_access

  def index
    @user = User.find_by({ id: params[:user_id] })
    render json: @user.followers
  end

  def update
    raise BlogExceptions::BadRequestError unless params[:user_id].present? && params[:id].present?

    FolloweesFollower.create({ followee_id: params[:user_id], follower_id: params[:id] })

    render json: {
      status: 'added new follower'
    }
  end

  def destroy
    FolloweesFollower.delete({ followee_id: params[:user_id], follower_id: params[:id] })

    render json: {
      status: 'Removed as a follower'
    }
  end

  private

  def resource_exists
    unless params[:user_id].present? && params[:id].present?
      raise BlogExceptions::BadRequestError, 'insufficient params'
    end
    unless User.exists?(params[:user_id]) && User.exists?(params[:id])
      raise BlogExceptions::BadRequestError, "User doesn't exist"
    end
  end
end
