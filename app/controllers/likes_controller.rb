# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authorized, only: %i[like unlike]
  before_action :params_exists?, :resource_exists?

  rescue_from BlogExceptions::BadRequestError, with: :bad_request
  rescue_from BlogExceptions::UnAuthorizedError, with: :deny_access

  def likes
    @post = Post.find_by({ id: params[:id] })
    render json: @post.likes
  end

  def like
    UsersLikedPost.create({ user_id: params[:user_id], post_id: params[:id] })

    render json: {
      status: 'like noted'
    }
  end

  def unlike
    UsersLikedPost.delete({ user_id: params[:user_id], post_id: params[:id] })

    render json: {
      status: 'Unliked'
    }
  end

  private

  def resource_exists?
    unless User.exists?(params[:user_id]) && Post.exists?(params[:id])
      raise BlogExceptions::BadRequestError, "User or Post doesn't exist"
    end
  end

  def params_exists?
    raise BlogExceptions::BadRequestError unless params[:user_id].present? && params[:id].present?
  end
end
