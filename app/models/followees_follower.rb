# frozen_string_literal: true

class FolloweesFollower < ApplicationRecord
  belongs_to :follower, foreign_key: 'followee_id', class_name: 'User'
  belongs_to :followee, foreign_key: 'follower_id', class_name: 'User'

  def create_pre_check
    raise BlogExceptions::BadRequestError, 'User cannot follow Themselves' if followee_id == follower_id
    unless User.exists?(followee_id) && User.exists?(follower_id)
      raise BlogExceptions::BadRequestError, 'Users should exists'
    end
  end

  before_create :create_pre_check

  validates :followee_id, uniqueness: {
    scope: :follower_id,
    message: 'User is already following this user'
  }
end
