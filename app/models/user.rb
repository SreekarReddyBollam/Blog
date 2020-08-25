# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  class_attribute :current_user

  has_many :posts, dependent: :destroy
  has_many :users_liked_posts
  has_many :liked_posts, through: :users_liked_posts, source: :post, dependent: :destroy

  has_many :followees_followers

  has_many :followers_relationships, foreign_key: :followee_id, class_name: 'FolloweesFollower'
  has_many :followers, through: :followers_relationships, source: :followee, dependent: :destroy

  has_many :followees_relationships, foreign_key: :follower_id, class_name: 'FolloweesFollower'
  has_many :following, through: :followees_relationships, source: :follower, dependent: :destroy


  before_update do |record|
    raise BlogExceptions::UnAuthorizedError unless User.current_user&.id == record.id
  end

  before_destroy do |record|
    raise BlogExceptions::UnAuthorizedError unless User.current_user&.id == record.id
  end

  validates :username, uniqueness: {
    message: 'Username has already been taken',
    case_sensitive: false
  }
  validates :password, format: {
    with: /(?=.*[A-Z])(?=.*[!@#\$\&^*])(?=.*[0-9]).{8,}/,
    message: 'Password must be of at-least 8 characters with one special character and a number'
  }
  validates :username, :first_name, :last_name, :password, presence: true
end
