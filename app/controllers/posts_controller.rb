# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authorized, only: %i[create update destroy]

  before_action :params_exists?, only: %i[update destroy show]

  rescue_from BlogExceptions::BadRequestError, with: :bad_request
  rescue_from BlogExceptions::UnAuthorizedError, with: :deny_access

  def index
    @user = User.find_by({ id: params[:user_id] })
    raise BlogExceptions::BadRequestError, 'User Not Found' if @user.nil?

    render json: @user.posts
  end

  def show
    @post = Post.find_by(id: params[:id])
    render json: @post
  end

  def create
    @post = Post.create(posts_params)
    render json: @post
  end

  def update
    raise BlogExceptions::BadRequestError unless params[:title].present? && params[:body] && params[:image_url]

    @post = Post.find_by({ id: params[:id] })
    @post.title = params[:title]
    @post.body = params[:body]
    @post.image_url = params[:image_url]
    @post.save
    render json: @post
  end

  def destroy
    @post = Post.find_by({ id: params[:id] })
    @post.destroy
    render json: {
      status: 'Done'
    }
  end

  private

  def params_exists?
    raise BlogExceptions::BadRequestError unless params[:user_id].present? && params[:id]
  end

  def posts_params
    params.permit(:title, :body, :image_url, :user_id, :id)
  end
end
