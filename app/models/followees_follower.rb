# frozen_string_literal: true

class FolloweesFollower < ApplicationRecord
  belongs_to :follower, foreign_key: 'followee_id', class_name: 'User'
  belongs_to :followee, foreign_key: 'follower_id', class_name: 'User'

  before_create do |object|
    if object.followee_id == object.follower_id
      errors[:following_same] << 'User cannot follow themselves'
      throw(:abort)
    end
  end

  validates :followee_id, uniqueness: {
    scope: :follower_id,
    message: 'User is already following this user'
  }
end
