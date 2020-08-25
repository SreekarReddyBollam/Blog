# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :users_liked_posts
  has_many :likes, through: :users_liked_posts, source: :user, dependent: :destroy

  before_update do |record|
    raise BlogExceptions::UnAuthorizedError unless User.current_user&.id == record.user_id
  end

  before_destroy do |record|
    raise BlogExceptions::UnAuthorizedError unless User.current_user&.id == record.user_id
  end

  validates :title, presence: true
end
